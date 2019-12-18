Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EDEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7504A227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHBG5JnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLROFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:05:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27433 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbfLROFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576677949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKeKFdBiRsbTRVEMHRwLpZNizEHEkznl+vD7uDZN8A0=;
        b=BHBG5JnMZe91augEFu/Orh3AOkVYhdyxJp7Oo8JqPD4/lLbH5W6LQlCgXkz2hWVe806URa
        yQHjZbj/id8nbtdk3HT4vFA0otQ+ftTIsBHBsR6HNMhP/ZNV5PU/sCyHqgkZKXT+wa3G5f
        S5NLArFfBmfX0JsvMFI3aRCDfbjXybs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-wsZ0yHyxPSyArG3puJUyWw-1; Wed, 18 Dec 2019 09:05:49 -0500
X-MC-Unique: wsZ0yHyxPSyArG3puJUyWw-1
Received: by mail-qv1-f69.google.com with SMTP id d7so1369864qvq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKeKFdBiRsbTRVEMHRwLpZNizEHEkznl+vD7uDZN8A0=;
        b=PBA1ByEL5s1ZlH23e4dqAV2JbMvDLaQ4IZ81MDa8QW6IzbToy0ypfM5mFFal4TxYg1
         IgnnPD28iehnOqyiA/+on2tGB3ZsyxmlUNZalszwwzN+2uzDKlvNWj/RN1myvHep06KG
         VkHvDUBwi5/lQ7dc6VJVDe03fOcOPwYhLNdCILsT2vYrdzw2VMAcnc2W8HRGRAkzZzRI
         AWYdUuZZ08zLD+NHGvdngpQ1gAuOwELrSWZ0PK5BW93/rQ0f5AMYXbtXCBZzh+dmDpwh
         T765b81tmnofqmn6HGggGjdEzR37FEC3IbBWCGCoedO0+toSjn/+82OMFJeFpq53dhb2
         blyQ==
X-Gm-Message-State: APjAAAVZj8V6qoa3ufX3IwxtwThWcqtcwS7Ygp+3EVpjDBIHaf37CmGR
        4hz0B00C2Szk1hEkgEeuDTfp3iiRUiyepwzczR6EdExLTh+MWz2RXdnQ6qosyA8wrUCxA9E/RUw
        BImvLudg4iq/xnBsMEyn2YurOc4O/K5PNC6p+Oemm
X-Received: by 2002:ae9:ef4b:: with SMTP id d72mr2603002qkg.27.1576677948192;
        Wed, 18 Dec 2019 06:05:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKvdiV0BKf8uQoqA75j4nlqoe0xziRqEhs2pVb5VXGW7tV9Z+/BlLLKm7sIxOMOgkkobh52Km32jESxnU5rbA=
X-Received: by 2002:ae9:ef4b:: with SMTP id d72mr2602972qkg.27.1576677947946;
 Wed, 18 Dec 2019 06:05:47 -0800 (PST)
MIME-Version: 1.0
References: <CAO-hwJ+5Ch02fPQ+XF=A4iEcH81V5PrCdV2qGQDZ8HxnQAoEog@mail.gmail.com>
 <1576585687-10426-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576585687-10426-1-git-send-email-zhangpan26@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 18 Dec 2019 15:05:36 +0100
Message-ID: <CAO-hwJLykG4zPquaHnJ0DL-Ce9CNre4Lpgg4naKp_EnDe7Wyzg@mail.gmail.com>
Subject: Re: Re: [PATCH v2] drivers/hid/hid-multitouch.c: fix a possible null
 pointer access.
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com, Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 1:28 PM Pan Zhang <zhangpan26@huawei.com> wrote:
>
> On Tue, Dec 17, 2019 at 18:50 PM Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
> >Can you add at the beginning of your commit message:
> >From: Pan Zhang <zhangpan26@huawei.com>
> >
> >This way we have the commit author that matches the signature, which is a requirement for the kernel.
>
> Firstly, thanks for your reviewing very much. I would fix my signature.
>
> >>  drivers/hid/hid-multitouch.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-multitouch.c
> >> b/drivers/hid/hid-multitouch.c index 3cfeb16..368de81 100644
> >> --- a/drivers/hid/hid-multitouch.c
> >> +++ b/drivers/hid/hid-multitouch.c
> >> @@ -1019,7 +1019,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
> >>                 tool = MT_TOOL_DIAL;
> >>         else if (unlikely(!confidence_state)) {
> >>                 tool = MT_TOOL_PALM;
> >> -               if (!active &&
> >> +               if (!active && mt
>
> >Ack on the principle, but this doesn't even compile. You are missing a `&&` at the end of the line.
> >
> >Can you send a v2 with the comments above? And we will queue the v2 for 5.5 I think.
>
> Sorry about that. I made a stupid mistake. This patch fixed it.

No worries, mistakes happen.

However, can you resend the patch to the LKML in a separate thread?
Also prefix the patch with "[PATCH v2]". It's easier for our tools to
handle patches when they are send on their own. Because here, I would
have to manually edit either the commit message removing the thread,
either take the first version and edit the patch. It's not so hard for
this kind of simple patches, but it's best to take good habits :)

Cheers,
Benjamin

>
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  drivers/hid/hid-multitouch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 3cfeb16..368de81 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1019,7 +1019,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>                 tool = MT_TOOL_DIAL;
>         else if (unlikely(!confidence_state)) {
>                 tool = MT_TOOL_PALM;
> -               if (!active &&
> +               if (!active && mt &&
>                     input_mt_is_active(&mt->slots[slotnum])) {
>                         /*
>                          * The non-confidence was reported for
> --
> 2.7.4
>

