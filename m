Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE7FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36E2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qrn+3EgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLQKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:50:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726655AbfLQKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576579811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt3wBXjdkOLTAGZAw3Tafg9k0wX1EERiUeh4YXdvZFw=;
        b=Qrn+3EgAZPFBLLyg2ECXeAk+dJeF5fBFO5P2JugKSba2jI6UlNpUqArs8627tm6BpV//b5
        PW0XPLTlI5WHKRMiaJAMIUT3yoeHDbtp7m7sTk6WzeVgVxrjucY5y2jxz3LXP6FTBt8eKC
        t5yzt8dXn3LpKVcjvxvpUamnn/YxvtY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-IfRpNcThPD-zI8UXpqFZLg-1; Tue, 17 Dec 2019 05:50:06 -0500
X-MC-Unique: IfRpNcThPD-zI8UXpqFZLg-1
Received: by mail-qk1-f197.google.com with SMTP id 143so6577151qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 02:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rt3wBXjdkOLTAGZAw3Tafg9k0wX1EERiUeh4YXdvZFw=;
        b=XQSjnIbvbBSkFDZzxoZ/bHmvYe8McnSxjFcvvY6dWm+i7V5QuNnMSwEr0o2yaJjEAT
         UagYQIZegzfPjZtfEsCLGJOATBD55H/yXKrFTwSXolqwtQF07Sq8y9zb35N3CMcCIp7O
         EB9zouB8pYQlQJ4BhsL+yr5vBmCdcXF1LCsjE18JWcPpAs62qX593A/t73mxpUzbqsD4
         X6W7JI58IHUUyxRyiQyIb9bVH5gEodqiOtZ07Uou/shC9XWY7iCTp6drzZSda/KFEQM9
         BPO5YcTO9pQ9C3Faa37NfQY0B6ArAxoYnu0DgbQmQG9p43cGHbvk1MOKtJf1Ib1QwdBM
         Im0Q==
X-Gm-Message-State: APjAAAXHZzUiDev0xxFwL1lF39G7r0GcPfwjZUcX1K/jxIugAl71XOUA
        OzMjIBACEwgPPjLSQjFiouHPVEFUIKLckzS5mhtIN63BWUIHup3dCojFpc7RRMLztHJyVpE+jey
        hUpDaAYacxvoMSFmXlD+jANONWD5e/BmPSws1EzG9
X-Received: by 2002:ad4:46ce:: with SMTP id g14mr3904989qvw.67.1576579805655;
        Tue, 17 Dec 2019 02:50:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/VLutc07+0j4Bx9/r9IYnqLdnpclrVJSO4VZrNxQqBV6UHMzCpcyo2Ftqj81CkaG3aSoCQu3p0VvOw1+5D9I=
X-Received: by 2002:ad4:46ce:: with SMTP id g14mr3904970qvw.67.1576579805418;
 Tue, 17 Dec 2019 02:50:05 -0800 (PST)
MIME-Version: 1.0
References: <1576551722-16966-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576551722-16966-1-git-send-email-zhangpan26@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 17 Dec 2019 11:49:54 +0100
Message-ID: <CAO-hwJ+5Ch02fPQ+XF=A4iEcH81V5PrCdV2qGQDZ8HxnQAoEog@mail.gmail.com>
Subject: Re: [PATCH] drivers/hid/hid-multitouch.c: fix a possible null pointer access.
To:     z00417012 <zhangpan26@huawei.com>
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

On Tue, Dec 17, 2019 at 4:17 AM z00417012 <zhangpan26@huawei.com> wrote:

Can you add at the beginning of your commit message:
From: Pan Zhang <zhangpan26@huawei.com>

This way we have the commit author that matches the signature, which
is a requirement for the kernel.

>
> 1002     if ((quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
> 1003         struct input_mt_slot *i_slot = &mt->slots[slotnum];
> 1004
> 1005         if (input_mt_is_active(i_slot) &&
> 1006             input_mt_is_used(mt, i_slot))
> 1007             return -EAGAIN;
> 1008     }
>
> We previously assumed 'mt' could be null (see line 1002).
>
> The following situation is similar, so add a judgement.
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
> +               if (!active && mt

Ack on the principle, but this doesn't even compile. You are missing a
`&&` at the end of the line.

Can you send a v2 with the comments above? And we will queue the v2
for 5.5 I think.

Cheers,
Benjamin

>                     input_mt_is_active(&mt->slots[slotnum])) {
>                         /*
>                          * The non-confidence was reported for
> --
> 2.7.4
>

