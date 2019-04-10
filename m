Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73262133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axRZSuON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfDJNLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:11:16 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39871 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfDJNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:11:16 -0400
Received: by mail-ot1-f50.google.com with SMTP id f10so1833668otb.6;
        Wed, 10 Apr 2019 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vwLXbeZwojB5WMPqtcpeoynXIm774SUqnDUMwoUczE=;
        b=axRZSuONoheetABQTv+aQ53ZLba5cOzXaoptfXMk1+G7Si3CGE6/PUoXtlH16VWqB5
         hSekAYPxwK5nmJIFdI9aFQIpv4z/n/88hMUUOIt2b7MTWaHwpG6/sin+wFCxr2CXzDvm
         oLGSxeDnjHHs5zJQJAT81Kqc8N5dDQapajPbrXhlScVOq6XJk3YrCt7kIYr0hUU4T3o0
         kfbYka+SN1hHj+BJjHqz1vrQbbcoOesv6bbsRPVKam0aJsnpNfnXbTTl+2IkfslAbAQr
         P/xvgC7uHu00gX3+S+39vFxYmbcpn+XptUuKuCv7LGaLGItQpF0NP9zByh6U3oj2RORR
         t1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vwLXbeZwojB5WMPqtcpeoynXIm774SUqnDUMwoUczE=;
        b=s3lhHjgA55NWGSGOcb3R/Mh53wmwMrkw53p/rRt8hqdh/LQ0e1OAFphVN0RTHVLZUK
         SZXu0bSiYJSDc9tBwmgtH3ABg370RNNwtVIuTcGvMlUBYCYwK8maAxZagK1DXgZXEYbp
         8v46uuWt0AVuUVaYmqRE3hlOtFkvcOFCx7XQmx6j/kGQPJQXJEixiNf43Ev4GWFNXGEZ
         H1Pxr0RMq/6dqybY+x6O0N7fS9XvbLguAxARhx0gkH1jRMycS5YUZn57mKcwSd4paIFH
         pVCGWK4X8kOwNQzHLkwxOiboGYa2JnPg8lLYKpQGGkd+EQfxeIk2VvLUoHbLBHnTNywS
         8l4g==
X-Gm-Message-State: APjAAAXtJhtyMatliHZO4TdMnYHBLDFv/lfm7fYZRuBihtTUXmvjww9W
        vJviHbu/+QXUNqTt5leZnEd/Lhs0mJpShcfkoAc=
X-Google-Smtp-Source: APXvYqwqsb+T1NA71OQZAw6JJmICZjjpEd/AoRua+T240hsiohUdIl1SJmWUCWJtfqwdiOw+sS4uESKxhuN2QeEjpds=
X-Received: by 2002:a05:6830:153:: with SMTP id j19mr24598475otp.248.1554901874946;
 Wed, 10 Apr 2019 06:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <20190409144250.7237-5-TheSven73@gmail.com>
 <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
 <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com>
 <CAGngYiX+53Rk2gTJ7G0QhQvEL-fF=Zan5jW9h7cR3gV1-J9xCg@mail.gmail.com> <CAL_JsqLx1a+rENo7QvF-ZXmpLG9Bf2-AGkTPP7hx+Nr_Uh+NvQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLx1a+rENo7QvF-ZXmpLG9Bf2-AGkTPP7hx+Nr_Uh+NvQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 10 Apr 2019 09:11:03 -0400
Message-ID: <CAGngYiXOedU=3KRnPVWcqhtP+zOcXtkwAuP_Grucr=Qo6Dj1=Q@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:10 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> No. If you send again, then add my R-by if it hasn't changed.

Thank you.

Greg, are you able to apply Rob's R-by tag if you merge this set as-is,
or would you like me to repost as v11 ?
