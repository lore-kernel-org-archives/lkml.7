Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEB12184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTOaL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:30:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34824 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:30:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id z13so14219636qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAfR56u9ah6iPy2ZaYD48292R6ocZ1r5g2CXJ/8Dj9s=;
        b=GWjUaKE5kBq3AQ0hVcQXXPG1+2So07x7qprW7qQLnGTI7InXsYJz1TWy+N4ZRw0LTz
         CWGECTCHjsDCkIMujBElNm+QLP7mAcqDvSilrorIryKrMXX0Ao+ARuQxeIWG3Qpvhqjv
         8mrQCTwmUBU7fx6tfUw1Ai9S7kvVw6voLAD6gOmLm0iilMQAFKon9z0CsTesoQtzfeHR
         yr14xx2nxX4SjOzpZvRZIa17g/zWF6W38/cA2Tn/YtTmrSAM4zxwbGeByopzrqUEOgXk
         wxRBDUXRPYSfsxrZt22SROGF0MQes4NpUSFSbIJ4R10run5oZOmvrJHzeadFTo9zxToP
         /o2g==
X-Gm-Message-State: APjAAAX7kXuIEiNR1MlcLQghS8qssT+fy0d25qUHkV0GNq1vMaOG2Pb+
        vuueXr5u9CThzOzS0TOBcnaZW0HhNEwO8x/8lG1/Jg==
X-Google-Smtp-Source: APXvYqyV68+d/ZA9sjus/zZ0I7xqLZ2iDFsElWvivpbyd31l+5gesThuJY7LGfkx4c+FwNw2H7c8dbiMuDmiZZeNV2I=
X-Received: by 2002:a37:4b49:: with SMTP id y70mr6894862qka.134.1553092209956;
 Wed, 20 Mar 2019 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190319224823.GA26366@jelly>
In-Reply-To: <20190319224823.GA26366@jelly>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 20 Mar 2019 15:29:58 +0100
Message-ID: <CAO-hwJJNzdx6DBj3vxgvnJz3aohtX_PBTP5YLAqAL2Rh4HeN=w@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech: Handle 0 scroll events for the m560
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        =?UTF-8?B?QWltbyBNZXRzw6Rsw6Q=?= <aimetsal@outlook.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:48 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> hidpp_scroll_counter_handle_scroll() doesn't expect a 0-value scroll event, it
> gets interpreted as a negative scroll direction event. This can cause scroll
> direction resets and thus broken scrolling.
>
> Reported-and-tested-by: Aimo Metsälä <aimetsal@outlook.com>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---

Added the 'Fixes' and "cc: stable" tags and patch applied to
for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..f040c8a7f9a9 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2608,8 +2608,9 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
>                 input_report_rel(mydata->input, REL_Y, v);
>
>                 v = hid_snto32(data[6], 8);
> -               hidpp_scroll_counter_handle_scroll(
> -                               &hidpp->vertical_wheel_counter, v);
> +               if (v != 0)
> +                       hidpp_scroll_counter_handle_scroll(
> +                                       &hidpp->vertical_wheel_counter, v);
>
>                 input_sync(mydata->input);
>         }
> --
> 2.20.1
>
