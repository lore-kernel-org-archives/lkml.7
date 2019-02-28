Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B61A218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBKAKjqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfB1TTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:19:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfB1TTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:19:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so10163077pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RAd0QQZng4fQskE3CujPczUuxrVI753C7t/+NAS6As=;
        b=dBKAKjqMErhfgXV+Sw1KhwV50LL2uEjl54KDmB2Fs2U7dVgR+oZOBaKbKG0mBkPvXY
         7EoYFex+11gKgwi6pb5MK27KFZhm5EUtarsq9Uiz5wTHbgZPoKW1iOV0TPYPHlCmYQiL
         uLuNOMjis5xmRZAYtDxysNXIRbNpr5VoEhpN7hxrysWhX4cIkk0trUdfFVx4GqMZVzXx
         PmNC4OJA1jbVcWia87gUAbmNixMeG1NFxtISv+aoRWsxqgJx+pazk2S4Cl5wgRVufMTG
         /KW5sTgf2aCdEkqzG3RVEvUsElPYBAlKEzl0GUlgK/dnkefJ/Tb1Au1i/IEDOIfUpQAD
         jNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RAd0QQZng4fQskE3CujPczUuxrVI753C7t/+NAS6As=;
        b=NzzGWQNC8fFI6I5xdB5m/Kj9xf7EkDqfCsFW7ImnCAMSgf+HYPT0GIKdECz3Kq54No
         sxHi8rnzDtSmXJ6QVtwREIgdEpQB9f06W99dmoN53jDrLVcHTDH86zD1cftwp/1fNBD8
         1KUM0cHYChZuxqQzlHVWgVD3QXWq5NIn2oCxvmzY0NxhAkUvdzexkjuVGofRwZBa5zkx
         KNykjHnoypSKKSE0ARFLY3xUNfWpJvNmmVkKsXLeiUwUBGLbIchScn40xWS0hxfz/YPP
         5M7j1OZEZNtb0MT9mFW/oIzKOse7NJRc7hZDJrbUIdqed3w6+TB4JAm/fpA1P/+UoR4I
         WZLQ==
X-Gm-Message-State: APjAAAV5UCpPbj3phRfNCi2v28wXyyK4TTLLy9xRCXTIKFNZNVr4//SO
        V2zGp/gbI9J7Fo94Zl62U8rQH3hKnyk6W8oPo8AunQ==
X-Google-Smtp-Source: APXvYqziJh173tg2asY5svnF2Qxrx7A3WaaJwyFv9S1DzaPbBImh3gCJiZM+mbq33xQQIitwvFCbeTRkReuL7TpWyl4=
X-Received: by 2002:a62:2b88:: with SMTP id r130mr1172498pfr.93.1551381560963;
 Thu, 28 Feb 2019 11:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20190228115256.5446-1-louis@kragniz.eu> <20190228122417.9318-1-louis@kragniz.eu>
In-Reply-To: <20190228122417.9318-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Feb 2019 11:19:09 -0800
Message-ID: <CAKwvOdkVBRpOgDdwUQoAA=pUBBZ1AqU_GxUkr7y-566NrXQbNQ@mail.gmail.com>
Subject: Re: [PATCH v2] wusb: use correct format characters
To:     Louis Taylor <louis@kragniz.eu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>,
        Stephen Hines <srhines@google.com>,
        inaky.perez-gonzalez@intel.com, david.vrabel@csr.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 4:28 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang warns:
>
> ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')

We should probably update Documentation/core-api/printk-formats.rst to
list [u|s][8|16] printk formats so that I don't have to go read
lib/vsprintf.c#format_decode(). (TODO in a separate patch)

> [-Wformat]
>   ckhdid->data[0],  ckhdid->data[1],
>   ^~~~~~~~~~~~~~~
>
> ckhdid->data is unconditionally defined as `u8 data[16]`, so this patch
> updates the format characters to the correct one for unsigned char types.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  include/linux/usb/wusb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
> index 9e4a3213f2c2..625366d3499e 100644
> --- a/include/linux/usb/wusb.h
> +++ b/include/linux/usb/wusb.h
> @@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
>                                    const struct wusb_ckhdid *ckhdid)
>  {
>         return scnprintf(pr_ckhdid, size,
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> +                        "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx "
> +                        "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",

Looks like lib/vsprintf.c#format_decode() accepts either %hh or %H for
lone unsigned bytes, IIUC.

Thanks for the patch and for following up on the feedback.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I wonder if __attribute__((packed)) is needed on the definition of
`struct wusb_ckhdid`? hmm...

via Stephen: https://godbolt.org/z/vs5JNo
Looks like alignof(struct wusb_ckhdid) is 1.  And struct wusb_ckhdid
was introduced as is in commit c7f736484f8e ("wusb: add the Wireless
USB include files.") so it's not like it ever had additional members
that would disturb the alignment. `__aligned(__alignof__(u8))` might
be clearer than `__attribute__((packed))`, but even then, I don't
think anything is necessary since the alignof should always be 1?

>                          ckhdid->data[0],  ckhdid->data[1],
>                          ckhdid->data[2],  ckhdid->data[3],
>                          ckhdid->data[4],  ckhdid->data[5],
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
