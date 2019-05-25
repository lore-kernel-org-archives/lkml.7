Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA9C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120F52133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FYaYk+QU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UluMDSWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEYFqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:46:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35437 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfEYFqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:46:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8ADA021C47;
        Sat, 25 May 2019 01:45:58 -0400 (EDT)
Received: from imap5 ([10.202.2.55])
  by compute1.internal (MEProxy); Sat, 25 May 2019 01:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=ecZFFYkyGooDDU4UAYrqow9TRzdY
        x/qSE7cRT3BSbyg=; b=FYaYk+QUzqpbiWPmPQlTsOzdVe+BkJJmnRzB6YBtvA5W
        VGcAughE1Wrqj6G+22Mh51eroOvtuGyLSIQqfqgt+KGTErAdT3Hr7SzTwol+aV60
        E4EELKY5l7U3r3oPdbKFxc41q+W29VG7qhXT+6TLXPnTKe+8MlGLOCQBO0/n6A1W
        XZxKBvn0anXOaYzIVdXw2301YItG0So2Yoj8cWrpctdbfOWAYXogMl9LbOk2EdeV
        FYHOgpnwv8ItqbVmUB0L5hiIvd6xXYUudoUdy39g/kWI6zrTAHlx6s7C1F+k7wr8
        4VEL/54uGFMICd0dHgFIxfiMGsegTW1c6dHDv3Mj/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ecZFFY
        kyGooDDU4UAYrqow9TRzdYx/qSE7cRT3BSbyg=; b=UluMDSWFlRDvhnaqomfrK/
        BqLOn6spA8HYzQahijYaE8eJFaJqixhMCku9N+w7kaVpGOPeESpo6V3/+Mis+DCL
        ZxsWETXXR0FglxYiIc8iINsLHeFSmgSTgjtNDbx4D445OoI5gDCiiRUNTjpCrLQ8
        dsByVE9HxZppdjjsuE3bhuHNNX9zcF2Ww/8PxKSn59U0uQPBIjJptfbzZ1S2k8LS
        HnInghtcMlUICegs8PGxHjaEHUofIinB5zmItZkkljxIq0ex4+Pv1ZpVImSVwCuz
        Pn1S8i4WrALFbIdPb35JKrau74z68Ynpatl4H/+f0zKVRpSFv9K2xC/OXCsasfAQ
        ==
X-ME-Sender: <xms:ldboXEUydlS3Lw-uhm2A1fAgLV3d64gPlgkDGO2hNotzdH-jE7Fd1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddujedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfvrghk
    rghshhhiucfurghkrghmohhtohdfuceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
    hirdhjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfrrghrrghmpehmrghi
    lhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhush
    htvghrufhiiigvpedt
X-ME-Proxy: <xmx:ldboXOkErS0AMw_t33rZoC--JEZSRAdiNT5MfY7q9lLlCNV0IBZZAg>
    <xmx:ldboXGBjKa4mr4UNbv2LiEXyxyOwWQolDkWshQAuxppHGDr4AqP6gg>
    <xmx:ldboXOfYQVvASZZS_nCHLqWv1diztlKxsAaFSGJJIRepsxBHN6LhQQ>
    <xmx:ltboXDavRseUQwZbvgjgEYS3HBkhK6trOfHK9Zc1iEQPBPrqDQbDiQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8EE445C0095; Sat, 25 May 2019 01:45:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-553-gc304556-fmstable-20190524v1
Mime-Version: 1.0
Message-Id: <9fe864d1-db6c-4b72-bfa3-3a1c638f1fae@www.fastmail.com>
In-Reply-To: <20190524213351.24594-1-colin.king@canonical.com>
References: <20190524213351.24594-1-colin.king@canonical.com>
Date:   Sat, 25 May 2019 14:45:57 +0900
From:   "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To:     "Colin King" <colin.king@canonical.com>,
        "Clemens Ladisch" <clemens@ladisch.de>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[alsa-devel]_[PATCH][next]_ALSA:_firewire-lib:_remove_redu?=
 =?UTF-8?Q?ndant=09assignment_to_cip=5Fheader?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Sat, May 25, 2019, at 06:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignement to cip_header is redundant as the value never
> read and it is being re-assigned in the if and else paths of
> the following if statement. Clean up the code by removing it.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/firewire/amdtp-stream.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/firewire/amdtp-stream.c 
> b/sound/firewire/amdtp-stream.c
> index 2d9c764061d1..4236955bbf57 100644
> --- a/sound/firewire/amdtp-stream.c
> +++ b/sound/firewire/amdtp-stream.c
> @@ -675,7 +675,6 @@ static int handle_in_packet(struct amdtp_stream *s, 
> unsigned int cycle,
>  		return -EIO;
>  	}
>  
> -	cip_header = ctx_header + 2;
>  	if (!(s->flags & CIP_NO_HEADER)) {
>  		cip_header = &ctx_header[2];
>  		err = check_cip_header(s, cip_header, payload_length,

Thanks for the fix. I've already posted further patch for refactoring
and this was also fixed by a commit 98e3e43b599d ("
ALSA: firewire-lib: refactoring to obsolete IR packet handler").

https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=98e3e43b599d742c104864c6772a251025ffb52b

Thanks


Takashi Sakamoto
