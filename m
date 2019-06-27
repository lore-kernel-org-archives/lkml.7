Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6CBC5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C6920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561678914;
	bh=78SChau8nc/c1cE2Dc8hBwWP8MHlNLa/2/RRRHYTTBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TlEa3hUevPBMBQnheo0UHTo6k9BFk0SyTmP/rr5BRzOK9RJptcrCRESRLWAlBRwEi
	 xTjwLJsjfihMlEoILFih5oBf5VzoaAjBSq4cPXmoe4MvaCub45QdEVnDiHpmoxeSYs
	 vzxw3CIKKaqZSXtUz8GnTQlcR3lN8izNBjgc4URg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfF0Xlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfF0Xlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:41:53 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC31F208E3;
        Thu, 27 Jun 2019 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561678912;
        bh=78SChau8nc/c1cE2Dc8hBwWP8MHlNLa/2/RRRHYTTBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WY42jKzHRez627ToGgM55/WghYYH2Kd/+jPHX6Bn8WWc+PNCFMvfO8Ms8jKvtvqEq
         m+4id6Is6WVNgVPDJ4B7svfCYUI4T4NeIIH/uolDIlsQLR8LOqMDxgWesIKgYb1WDj
         5d/i1PKbaPL+t3T5LyL001tJIEHEXuDdUotEqFh4=
Date:   Thu, 27 Jun 2019 16:41:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190627234149.GA212823@gmail.com>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaskaran, one comment (I haven't reviewed this in detail):

On Wed, Jun 19, 2019 at 12:10:48PM -0700, Jaskaran Khurana wrote:
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index db269a348b20..2d658a3512cb 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -475,6 +475,7 @@ config DM_VERITY
>  	select CRYPTO
>  	select CRYPTO_HASH
>  	select DM_BUFIO
> +	select SYSTEM_DATA_VERIFICATION
>  	---help---
>  	  This device-mapper target creates a read-only device that
>  	  transparently validates the data on one underlying device against
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index be7a6eb92abc..3b47b256b15e 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -18,7 +18,7 @@ dm-cache-y	+= dm-cache-target.o dm-cache-metadata.o dm-cache-policy.o \
>  		    dm-cache-background-tracker.o
>  dm-cache-smq-y   += dm-cache-policy-smq.o
>  dm-era-y	+= dm-era-target.o
> -dm-verity-y	+= dm-verity-target.o
> +dm-verity-y	+= dm-verity-target.o dm-verity-verify-sig.o
>  md-mod-y	+= md.o md-bitmap.o
>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o

Perhaps this should be made optional and controlled by a kconfig option
CONFIG_DM_VERITY_SIGNATURE_VERIFICATION, similar to CONFIG_DM_VERITY_FEC?

CONFIG_SYSTEM_DATA_VERIFICATION brings in a lot of stuff, which might be
unnecessary for some dm-verity users.  Also, you've already separated most of
the code out into a separate .c file anyway.

- Eric
