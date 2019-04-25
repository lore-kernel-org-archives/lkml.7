Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EEBC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9461218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfDYJnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:43:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41873 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfDYJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:43:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id f25so14911052qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnCw0XoCzQ1ROmREQCNZILg9/FRjfK1Z8blFDO3jQE0=;
        b=l0Yf5yf98aME7ucZPtq8+YeyzYKI/wbbioXr0opzcZmxyaWDIpTL86btroikgEsvaN
         lG2kHig+WlV1y6KhW6rs1YoDcNYn8K1g0jiljsqXLOGiSRWT1k343LFf0eJbsBV6vAtO
         imvHG1N5zdZlQzQ0BpsJhtg8HAUl94JufUhY3YfecFnrVZ5226hjkf/R01waEKMk9d8I
         6ZrKx4aoU1z8F0FYB40wYb7IHI746+MglPtJlt+CEQldZn6JNrjJfgYAQmu0cXEL5tjD
         EJXN2YbcV7vkZWR+x+uI63bu+oBraLnRxJEhlVz7/oY7jYCAnlYNoIo4+hrBsMcLaIgc
         6dEg==
X-Gm-Message-State: APjAAAUDwgBr7dhhdoxL9ktiTEqM4U15E/Lk7WxpEstI/d5G2/oarHZB
        9xFF+2BY52QFi4hUyFlna6sKB6abKUPPR44cKMOfOg==
X-Google-Smtp-Source: APXvYqyMCn16M4jZc9wTAfHIRlDX0EmQM778gH/DvpMSTYxe7AdWJI7ug1yl6uWzw8ejaing/69/JgdPNoSKXLoVbhw=
X-Received: by 2002:ac8:24cf:: with SMTP id t15mr31036134qtt.112.1556185381278;
 Thu, 25 Apr 2019 02:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190308051117.21899-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 Apr 2019 11:42:50 +0200
Message-ID: <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, Mar 8, 2019 at 6:11 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
> to 256") increases the max report size from 128 to 256.
>
> We also need to update the report size in hid_field_extract() otherwise
> it complains and truncates now valid report size:
> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)
>
> BugLink: https://bugs.launchpad.net/bugs/1818547
> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9993b692598f..860e21ec6a49 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned offset, int n)
>  u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>                         unsigned offset, unsigned n)

Ronald (Cc-ed) raised quite a good point:
what's the benefit of removing the error message if this function (and
__extract) can only report an unsigned 32 bits value?

My take is we should revert 94a9992f7dbdfb28976b upstream and think at
a better solution.

Cheers,
Benjamin

>  {
> -       if (n > 32) {
> -               hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> +       if (n > 256) {
> +               hid_warn(hid, "hid_field_extract() called with n (%d) > 256! (%s)\n",
>                          n, current->comm);
> -               n = 32;
> +               n = 256;
>         }
>
>         return __extract(report, offset, n);
> --
> 2.17.1
>
