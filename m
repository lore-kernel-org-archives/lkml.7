Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F69218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556066610;
	bh=RtMtSz3NQUbjm0bLWM70F+7EC5C8vn6o2WIkxmRA7Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhVyQmBzM8QcTPRK6zZsSSxxfQ2Sko+IKN85SmaCrpFbip1HupeaT4tnoWDQ+v7Bt
	 +vT9fCPciVNhT5QnzGOxeJiH0ZInvgW3p3jtLvF1EUX/PLOZwkw87FsqCjAPQ7kjpb
	 1hCOWprjqe+wv2KaXEtgKToQFeaQyU/iT3qfYC/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfDXAn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfDXAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:43:29 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8784214C6;
        Wed, 24 Apr 2019 00:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556066608;
        bh=RtMtSz3NQUbjm0bLWM70F+7EC5C8vn6o2WIkxmRA7Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKS0aITW2qi+M/f3TvJKsFIKNrwm7X9IbnpF0co0XzdlX0JyBMc//YOdXNPxNRbbp
         F8JDRt35dfGY4y5A01RT/93/a2POUBHXVw+SrvcO74kYGf3BeOitiOJrRHR/joKsQk
         kSKtc0edn4cmtJJ3JRh3aIBQis1EJYGr7uht9jN8=
Date:   Tue, 23 Apr 2019 20:43:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jonas Witschel <diabonas@gmx.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190424004326.GX17719@sasha-vm>
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net>
 <20190409134421.GD9759@linux.intel.com>
 <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:54:47PM +0200, Jonas Witschel wrote:
>On 2019-04-09 15:44, Jarkko Sakkinen wrote:
>> On Mon, Apr 08, 2019 at 02:01:38PM +0200, Thibaut Sautereau wrote:
>>> [...]
>>> What's the status of this patch now? It's needed in linux-5.0.y as TPM
>>> 2.0 support is currently broken with those stable kernels without this
>>> commit.
>>
>> part of a PR.
>>
>> https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/
>
>It appears that the final version of the patch that was merged to
>Linus's tree [1] does not include the "Cc: stable@vger.kernel.org" tag.
>If I understand correctly, this means that the patch will not be
>automatically included in the -stable tree without further action. Is
>there a specific reason not to apply this patch to 5.0.x, or did the tag
>just get lost in the merge process?

Good catch; I see that Jarkko had the same comment on v3 but v4 ended up
being without the -stable tag without any explanation. I've queued this
for 5.0, it doesn't seem relevant for older branches.

--
Thanks,
Sasha
