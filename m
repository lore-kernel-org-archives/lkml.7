Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5C6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9527220833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fKGa7by9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfDOGHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:07:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36919 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDOGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:07:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id o19so7743553lfl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GW7M4MHHIkdd6HVQz82d2WszDsg/6I6fTV7AdaP6ddI=;
        b=fKGa7by9308ZG4pUNv72cXFoW8iWW29xMC86t01xUJ5gLEwQefS/JYG7GZVgjPRgJh
         jdx8VzNKD2TRtjY8P0p+xNnaVhsrHWbbkwUlz2hYG9dSRXPI5vfS0SW5Wt2tDalm8XDY
         XkYx+BvxWJoVY9KyK/H+iHPDpn15fteLUo6BgxyBy0Y1TdNTLJ3gM/JtCtxQz0Fp6Unv
         w1YO/7iLm6c7dTu6lkr4jciS0tom/y++q49nIsKPRWEIxpMzShtXwwtgeTqPFAnoBskq
         BfQVLr9NhvF/d8+uX3++dvsJS/tknxSJlqnPs0/mQv8STnCoQfiEd4W41Jut5YbfT93p
         TLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW7M4MHHIkdd6HVQz82d2WszDsg/6I6fTV7AdaP6ddI=;
        b=hWqVPWYER5AJnH1FnUjZ137H9xO1F/qWszHTXi9EO5ky8wC7Ea5zFCtLT+5q+TKYxR
         XIMjLFfwxo6pvDI6dEaQHkXkyv2haU6Dqfn45EOodFHScuAPq9Cd8wXoq68S5Ro1iZ7N
         MFxf5RcBgF8rXtGOB/lfAjGq1pOhHqmFFVXZYGUeROeKBMWO+Pp4Ad6o8g/itggb4Q5r
         OxUoawsGhWVZXIhz78zLZJFQsTHoMSh17nVFlSR31ig+nSBkD1f+CbH9VKnG0k/Pyg0X
         ACnK7xUDg+ZpB3VUS4vgWyyCbpTP874qXV4ppKfo1mEbSvziuQcqkao7KnrnfXq3tFfk
         xKpg==
X-Gm-Message-State: APjAAAUMQDNQqfKsUABlqsdJLVF4qQ9yGU1PdWV5LWVl0V7HW7+TgaUh
        Ls4voKf6u01DAXD3WghYv59wCkUsbRMjz5LPYwprhQ==
X-Google-Smtp-Source: APXvYqzRmGYbJwfZKgoXZng5xC6EIs3HK92tsvwK9Xlv6E90GYGlv0vzWnDND9BQbN5cO2R61NRo3nQcYoo7vk/b2Zw=
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr16750868lfl.67.1555308447972;
 Sun, 14 Apr 2019 23:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 15 Apr 2019 11:36:51 +0530
Message-ID: <CAJ2_jOF8RsLWHkcCJzwfpeMN0+G0oqbHto=nBBnpZDNfuQMKOw@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
To:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments on this patch series?
Any more changes are needed or it looks good to be merged upstream?

- Yash
