Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7033C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578366872;
	bh=E9/8p5B7oPg0uiqg4UpaYHTvWRDU095e/2vCZwqujMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SD4v4RIQQg4maqv24j4grjaRbl2McCLOLqTn0M5GLjh14rRkpdEuzdcG3UMDOhX3V
	 UG65XMR/c33rAfSwLSEeA46i2Eb5ZwQZHNr0P4CNt6pFs/AwdogzIQW45+pJCAPWJM
	 ctnK8NXQzsk+9zujxv1TuLkNNCJYM2iVGGN0uS/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAGDOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGDOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:14:31 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B182F2075A;
        Tue,  7 Jan 2020 03:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578366871;
        bh=E9/8p5B7oPg0uiqg4UpaYHTvWRDU095e/2vCZwqujMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z73zzkF7jkeYbFC1ete0J7l5Gs1w/r8FTSQEiafb0NuioT7quruDw+3kM6BpBpB3P
         5A0xQEbQIlIOOPmDr/RHVoIEmGG8ADIOlTINhJA4sUh0qUVolTKFCP8CWq+HBKWG62
         RtNasi6iojBE7PtSQRqDL6hGnHWoD/uHrWr0+9DQ=
Date:   Mon, 6 Jan 2020 19:14:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     zhou_xianrong <zhou_xianrong@sohu.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org, agk@redhat.com,
        snitzer@redhat.com, wanbin.wang@transsion.com,
        haizhou.song@transsion.com,
        "xianrong.zhou" <xianrong.zhou@transsion.com>,
        "yuanjiong . gao" <yuanjiong.gao@transsion.com>,
        "ruxian . feng" <ruxian.feng@transsion.com>
Subject: Re: [PATCH] dm-verity:unnecessary data blocks that need not read
 hash blocks
Message-ID: <20200107031429.GA705@sol.localdomain>
References: <20200107024843.8660-1-zhou_xianrong@sohu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107024843.8660-1-zhou_xianrong@sohu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:48:43AM +0800, zhou_xianrong wrote:

> Subject: [PATCH] dm-verity:unnecessary data blocks that need not read

Please use a proper commit subject.  It should begin with "dm verity: " and use
the imperative tense to describe the change, e.g.

	dm verity: don't prefetch hash blocks for already-verified data

Also this should have been "PATCH v2", not simply PATCH, since you already sent
out a previous version.

You also sent out multiple copies of this email for some reason, so I just chose
one arbitrarily to reply to...

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 4fb33e7..4127711 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -611,8 +611,27 @@ static void verity_prefetch_io(struct work_struct *work)
>  
>  static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
>  {
> +	sector_t block = io->block;
> +	unsigned int n_blocks = io->n_blocks;
>  	struct dm_verity_prefetch_work *pw;
>  
> +	if (v->validated_blocks) {
> +		while (n_blocks) {
> +			if (unlikely(!test_bit(block, v->validated_blocks)))
> +				break;
> +			block++;
> +			n_blocks--;
> +		}
> +		while (n_blocks) {
> +			if (unlikely(!test_bit(block + n_blocks - 1,
> +				v->validated_blocks)))
> +				break;
> +			n_blocks--;
> +		}
> +		if (!n_blocks)
> +			return;
> +	}

This looks fine now, though it's a bit more verbose than necessary, and I don't
think unlikely() will make any difference here.  Consider simplifying it to:

	if (v->validated_blocks) {
		while (n_blocks && test_bit(block, v->validated_blocks)) {
			block++;
			n_blocks--;
		}
		while (n_blocks && test_bit(block + n_blocks - 1,
					    v->validated_blocks))
			n_blocks--;
		if (!n_blocks)
			return;
	}
