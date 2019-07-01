Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14995C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C7B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="b5Iea5vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGAXwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:52:04 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35850 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAXwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:52:04 -0400
Received: by mail-pg1-f171.google.com with SMTP id c13so6744553pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U3UCHfQa0yO6+9MSJSdhp8ydnzBOoWVKB7F2MUDXIbg=;
        b=b5Iea5vhGThzBv+VWqfZbdQPWSQb/trP2oBbiSl1ZLRctqr33FGui2k/L5AGnmsaV7
         22BsGyqjddZ3Wi5jEi48VQUnbZznpyn2+DkAdVy3r8kSlaGNo04U+/udCAyV3AjEqF5v
         Bkjrem0QYozuKu9xpdQRdVpt7Z1Va3i7P4HXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U3UCHfQa0yO6+9MSJSdhp8ydnzBOoWVKB7F2MUDXIbg=;
        b=j9YDhCauYuv0ije+VoOKxV6SEosTy3Gm82IWVWLxRowikzxUWwdbwiUxrzlrp5OdED
         TrnfiaCoyV7SqYLrDpt8YY3FjvOReLotQITf/RNWdSJEC101Y8BT2KegGWcm5Dn0N/f3
         c0+aQc7bHE7uvs8AYMRj/JCZ3UBln6YG1xN9CUboG7v58hujbruP0HBVT9vRT1cf5Bqz
         TEtsBOCaCRxIEMsIUCrQLqHoV1LH7/xnO+kAHA0+Ytya2AWRTF6SQ7DnbNyvFbLwTpFs
         y9c1OSIigtqEZ1RKFEgOr53ev5byBZPZRsoq4J+RgNM5lP1zVN+qk75pOXmg8YgJwtbi
         Cr/g==
X-Gm-Message-State: APjAAAVeOKnZarkg9xRi2bYAO92xqp8B3pREJNThb3yEPjZfnyHvD437
        RpZ6iBfCSxl17u+qXUc5mSKN
X-Google-Smtp-Source: APXvYqz0b5AzL/SN3RQHm/dlupgSF+1Fo4cZiZxEFKyd+V0xZqiqECBH1Pl8dWl5yxYv7lc45QuLDA==
X-Received: by 2002:a63:4f65:: with SMTP id p37mr27044600pgl.327.1562025123383;
        Mon, 01 Jul 2019 16:52:03 -0700 (PDT)
Received: from [192.168.1.144] (64-46-6-129.dyn.novuscom.net. [64.46.6.129])
        by smtp.gmail.com with ESMTPSA id y12sm11153359pgi.10.2019.07.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 16:52:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: net: check before dereferencing netdev_ops during busy poll
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <CAGnkfhx3ykbEsW+=FtpMFWU=_Vnie7RpPYWpWqa1S1HPMXj9kw@mail.gmail.com>
Date:   Mon, 1 Jul 2019 16:52:01 -0700
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Message-Id: <AFBE995B-8C7D-430D-B722-615C6CBBF6E9@appneta.com>
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
 <20190628225533.GJ11506@sasha-vm>
 <1560226F-F2C0-440D-9C58-D664DE3C7322@appneta.com>
 <20190629074553.GA28708@kroah.com>
 <CAGnkfhzmGbeQe7L55nEv575XyubWqCLz=7NQPpH+TajDkkDiXg@mail.gmail.com>
 <20190701175241.GB9081@kroah.com>
 <CAGnkfhx3ykbEsW+=FtpMFWU=_Vnie7RpPYWpWqa1S1HPMXj9kw@mail.gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 1, 2019, at 11:03 AM, Matteo Croce <mcroce@redhat.com> wrote:

> Josh, as you are the original author, can you please resend it to -stable?
> Feel free to add this tag:
> 
> Tested-by: Matteo Croce <mcroce@redhat.com>

For sure. Resent with your Tested-by, along with a second patch that applies 
to the 4.4.y LTS kernel.

I'm still a little hazy on how net fixes work for older LTS releases, so I
hope I've sent these properly. I can respin if necessary.
