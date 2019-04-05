Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0FBC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6DF2173C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLSTcoWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDEVVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:21:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44242 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:21:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so9063322qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dpxx/MPLM5U9jBhNiMPxgjV+FsSZSY4WqIn1eJmAXcQ=;
        b=HLSTcoWhJV2FaRyws/H1jCa/x5KsSulMnTJ2WnBPZyid1fJaAc56euf9J2Jc3kXjIP
         5Ua2SVYnegWFn5lHbsWWp6bABDHQOROp2k/Zi9n60+my2h5r2lHqTo25ensXIN84NXG4
         5hKrl2Kcb3melDtQxCkQG4v9N6YoK5PQ76t4zeWH1aGq1gpXYdWJSz0O4FI+1r8TG9Qk
         O709YWtwupBEegdpY3iH2k9X8dWG3d3q6eyQeOErwyFKoEypgPjgb3nbvqmG+hyZRbdt
         DboHwnr4d0wWnS93v5hl/VLEISL8Jtn2C0AmLIs5YPsfV89r9+JfAKrNF8YH7LXhMD59
         Q+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dpxx/MPLM5U9jBhNiMPxgjV+FsSZSY4WqIn1eJmAXcQ=;
        b=uVpgm4FiWtZK09P2/VQYMuwelqhM+bF+mVGsZ12zUHL81orISsqCH4BNPQmtD8vxvU
         47HYtCa4GgU7CtJi/42O/gZvUL6zOumUiF/KlVJaKzWtwcxEppYbq3vJgFw45ywfUrSB
         t8nUJzlJo6fdtZSL5K/7GQJWxnjA2W1wANaRKRqeaC7Kpah0b/Uk5PhdSaeQEYM7Nehc
         20WEE7+tSLr8tdJm4/Yj+aLQSh30Qirtg8ngQp6cN0JGyKAnPVCdBrgvMrxl2gL7+KkU
         k/vJ9r/ju/IbqEOWvg9/whnuvgFRvlCecV/5a22GKV2HRIiVXRSos01L3W/nsg0HLiA/
         NXHg==
X-Gm-Message-State: APjAAAUo0c6lv33vd1vbdgacqUBg8DI4qAECu6fHNanSYHPJ7Asm1Vdd
        ba7MVM1rcDZn5XHiTXl1U51EOlbuonscmFsSQQE=
X-Google-Smtp-Source: APXvYqw+EQ5Xc50fJIPhJtZ1pTuPSxQPFHWPX6CIO318OIjz8onpfodhbhL8nxI64JbglCj2OCM6zHSuJtXDgaNF1UU=
X-Received: by 2002:ac8:85c:: with SMTP id x28mr13611833qth.90.1554499302348;
 Fri, 05 Apr 2019 14:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190405200742.107973-1-ncrews@chromium.org>
In-Reply-To: <20190405200742.107973-1-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 5 Apr 2019 23:21:31 +0200
Message-ID: <CAFqH_52zYVjg1aZ4JujZxh591Opbkfw=7FS8Bmwmn5Wao3N-xw@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: wilco_ec: Standardize mailbox interface
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>, lamzin@google.com,
        sjg@gchromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Missatge de Nick Crews <ncrews@chromium.org> del dia dv., 5 d=E2=80=99abr.
2019 a les 22:09:
>
> The current API for the wilco EC mailbox interface is bad.
>
> It assumes that most messages sent to the EC follow a similar structure,
> with a command byte in MBOX[0], followed by a junk byte, followed by
> actual data. This doesn't happen in several cases, such as setting the
> RTC time, using the raw debugfs interface, and reading or writing
> properties such as the Peak Shift policy (this last to be submitted soon)=
.
>
> Similarly for the response message from the EC, the current interface
> assumes that the first byte of data is always 0, and the second byte
> is unused. However, in both setting and getting the RTC time, in the
> debugfs interface, and for reading and writing properties, this isn't
> true.
>
> The current way to resolve this is to use WILCO_EC_FLAG_RAW* flags to
> specify when and when not to skip these initial bytes in the sent and
> received message. They are confusing and used so much that they are
> normal, and not exceptions. In addition, the first byte of
> response in the debugfs interface is still always skipped, which is
> weird, since this raw interface should be giving the entire result.
>
> Additionally, sent messages assume the first byte is a command, and so
> struct wilco_ec_message contains the "command" field. In setting or
> getting properties however, the first byte is not a command, and so this
> field has to be filled with a byte that isn't actually a command. This
> is again inconsistent.
>
> wilco_ec_message contains a result field as well, copied from
> wilco_ec_response->result. The message result field should be removed:
> if the message fails, the cause is already logged, and the callers are
> alerted. They will never care about the actual state of the result flag.
>
> These flags and different cases make the wilco_ec_transfer() function,
> used in wilco_ec_mailbox(), really gross, dealing with a bunch of
> different cases. It's difficult to figure out what it is doing.
>
> Finally, making these assumptions about the structure of a message make
> it so that the messages do not correspond well with the specification
> for the EC's mailbox interface. For instance, this interface
> specification may say that MBOX[9] in the received message contains
> some information, but the calling code needs to remember that the first
> byte of response is always skipped, and because it didn't set the
> RESPONSE_RAW flag, the next byte is also skipped, so this information
> is actually contained within wilco_ec_message->response_data[7]. This
> makes it difficult to maintain this code in the future.
>
> To fix these problems this patch standardizes the mailbox interface by:
> - Removing the WILCO_EC_FLAG_RAW* flags
> - Removing the command and reserved_raw bytes from wilco_ec_request
> - Removing the mbox0 byte from wilco_ec_response
> - Simplifying wilco_ec_transfer() because of these changes
> - Gives the callers of wilco_ec_mailbox() the responsibility of exactly
>   and consistently defining the structure of the mailbox request and
>   response
> - Removing command and result from wilco_ec_message.
>
> This results in the reduction of total code, and makes it much more
> maintainable and understandable.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/platform/chrome/wilco_ec/debugfs.c | 43 ++++++++-------
>  drivers/platform/chrome/wilco_ec/mailbox.c | 53 ++++++++----------
>  drivers/rtc/rtc-wilco-ec.c                 | 63 +++++++++++++---------
>  include/linux/platform_data/wilco-ec.h     | 22 +-------
>  4 files changed, 83 insertions(+), 98 deletions(-)
>

Now I'm confused, isn't this the same patch I picked this morning from
you and is already applied in chrome-platform for-next?

[snip]
