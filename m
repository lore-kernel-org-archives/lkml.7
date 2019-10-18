Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D6CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB1920820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qz9YB1cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406931AbfJRF6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:58:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45913 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392149AbfJRF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:58:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so4234009qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aspMadhLtLdwap/HY8pYXIpI/022GVepCK2sUy5Jo4=;
        b=Qz9YB1cp2Zg6eSsNCQvAw6Xl7TdE+kvgwqY9mVMHfLFdjXB02ass8EAgL5EVNdqguV
         oidctHw4mrvIPU8WCuzS+lKh4XCCv8TRwm6eyjKrm8zPZEfkMLCUib6g57hPc6TISL0R
         RYuybrnZ7s4TaWGAE/9ruSfal9/1BdXMvE0DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aspMadhLtLdwap/HY8pYXIpI/022GVepCK2sUy5Jo4=;
        b=R/Oty0jT2ClvnlAJSq/+35JrPmzdo7PmXeLeCCFsiiwRb2rr0PiZduQ9tqcBVAe/MF
         SyqoDO2kBZNHAn88BrcovlUUUhBNIUtPYRc02MoOv9Q0HpZgYEgDqh2aSyRP6iFKzWrT
         TzPAZzH9VsEP0ESKGJ4V6mm0i/VOH7ZwswtDSwXCj1NnaYPSuKQUZnBSue7xEJsi8Lhl
         sEyfqY53lGQsbuf4CVKgpPJYf+BNtj0COhBajBm8I65WF36N7YvFx+wQGIwrR8v0j7PR
         OUGVV43s0bJAnUZsuHMUIrLu9ohIZltcR6LVUZCjEKjKmP5SipHIX4AN4dwpVpTzXCJu
         T0aA==
X-Gm-Message-State: APjAAAUWqUbL8GDzHsFSbyDQtfezocmNWdaHU+DJ8sgZunN2KWCNaeY/
        XZQlJfYr0Qr+4NWFZ69opPnAx7PzrFg=
X-Google-Smtp-Source: APXvYqyIjBpcpB6jq882+x2E0wMS8eqwRG+Ez9krlw9zYDkWZLZGBG5mbl4ueLkU6hZ81m8ARLBvLg==
X-Received: by 2002:a37:6f06:: with SMTP id k6mr6673631qkc.143.1571367608944;
        Thu, 17 Oct 2019 20:00:08 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id n17sm2402624qke.103.2019.10.17.20.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 20:00:07 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id u22so3961864qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 20:00:07 -0700 (PDT)
X-Received: by 2002:ae9:f30c:: with SMTP id p12mr6409294qkg.159.1571367606688;
 Thu, 17 Oct 2019 20:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191009085116.199922-1-tientzu@chromium.org> <238f01ec4b49fee4c0d08a0b8da7e95f@codeaurora.org>
 <74740c0ff64a6a658da2a44a9f9b7ac5@codeaurora.org>
In-Reply-To: <74740c0ff64a6a658da2a44a9f9b7ac5@codeaurora.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 18 Oct 2019 10:59:54 +0800
X-Gmail-Original-Message-ID: <CALiNf2_EcJxxTYd52UVyaJ-Q82YPM5MKTPBmMNUrBZryEShwqw@mail.gmail.com>
Message-ID: <CALiNf2_EcJxxTYd52UVyaJ-Q82YPM5MKTPBmMNUrBZryEShwqw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Rocky Liao <rjliao@codeaurora.org>, rongchi@codeaurora.org,
        linux-bluetooth-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

Sorry for the late reply. I was on vacation for the past few days.
The chipset we use is QCA6174A-3 and rjliao has already confirmed that
IBS won't work without RAM fw downloaded.
Please ignore this change.

Thanks,
Claire


On Fri, Oct 11, 2019 at 3:21 PM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
> Hi Claire,
>
> This change will not work  as we need fw files to be loaded tofor IBS to
> active.
> may i know on which chipset you have this issue of IBS active even with
> out fw download.
>
> On 2019-10-11 12:31, Harish Bandi wrote:
> > ++ Balakrishna
> >
> > On 2019-10-09 14:21, Claire Chang wrote:
> >> Enabling in-band sleep when there is no patch/nvm-config found and
> >> bluetooth is running with the original fw/config.
> >>
> >> Fixes: ba8f35979002 ("Bluetooth: hci_qca: Avoid setup failure on
> >> missing rampatch")
> >> Fixes: 7dc5fe0814c3 ("Bluetooth: hci_qca: Avoid missing rampatch
> >> failure with userspace fw loader")
> >> Signed-off-by: Claire Chang <tientzu@chromium.org>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index e3164c200eac..367eef893a11 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -1291,10 +1291,8 @@ static int qca_setup(struct hci_uart *hu)
> >>      /* Setup patch / NVM configurations */
> >>      ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
> >>                      firmware_name);
> >> -    if (!ret) {
> >> -            set_bit(QCA_IBS_ENABLED, &qca->flags);
> >> -            qca_debugfs_init(hdev);
> >> -    } else if (ret == -ENOENT) {
> >> +
> >> +    if (ret == -ENOENT) {
> >>              /* No patch/nvm-config found, run with original fw/config */
> >>              ret = 0;
> >>      } else if (ret == -EAGAIN) {
> >> @@ -1305,6 +1303,11 @@ static int qca_setup(struct hci_uart *hu)
> >>              ret = 0;
> >>      }
> >>
> >> +    if (!ret) {
> >> +            set_bit(QCA_IBS_ENABLED, &qca->flags);
> >> +            qca_debugfs_init(hdev);
> >> +    }
> >> +
> >>      /* Setup bdaddr */
> >>      if (qca_is_wcn399x(soc_type))
> >>              hu->hdev->set_bdaddr = qca_set_bdaddr;
>
> --
> Regards
> Balakrishna.
