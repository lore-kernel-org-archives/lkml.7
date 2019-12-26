Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3CDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07FE20828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F/35XYsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLZSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:52:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40700 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfLZSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:52:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so6642460wmi.5;
        Thu, 26 Dec 2019 10:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ypv1P+w8u0b0xjjfk63+8/r3fcQQ50esgG/WxnES284=;
        b=F/35XYsCTf2aMj5zaXMWHKeSm3rrKNRco1feL0oBX2a3PYEiLiNAXf+YLSBNl5Xxlg
         orKHkmAhn5ACBZOz8ibgXQ18cgBNFtC1XwNvIT7Gr3H1SCjXScO0jOqAHKh1qUXXybvv
         xmPAcEhIgSXuAwALHZFy8OzlTezEQpwlqYOqGfvd5sglTbwFM/IXpk8yritCeSViRWbw
         m6yRCsaBiubozEzpqnmaxZUE9wuqBx1rrjxW8fD75pFWb45MeAYlFsJa0xk/WitRlMDd
         SlTU8M1IwGO0PJayZ8hPxsc7Cp5kfVsm4LNJup58YKp2g4c+jEf1Wd8nQ9rnZ/IujWa6
         kXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ypv1P+w8u0b0xjjfk63+8/r3fcQQ50esgG/WxnES284=;
        b=DNqs4kFYAD+gXzvJ5WINeszCunKQ3G3/FIxnRZ8QWjYuwKNi4txrA8891mSkZ+XKjh
         oxjj7A7qfVaFWMnlmsgBDhMQyUB4hwMu5nfkEp1Z1T7WeRbHMX/z6GlYbWvQ63PBd/le
         7royTqpbBf+10tUOEOg9Me+Jg3MNmQkJUEwq5d+DEGjICCyyGCbpHU+bIJW/JzQWGwvc
         YIsDFw0+LvXsuf+llF8aojNAaNAgojVveWoY8fpFCr2p3lKUI5XkBEFja8hWezZsiYnI
         FIfz9MRPcaTRiIAD+ncOWeRb+PX9AFyLR54D0y7aeRbWgnBeJYg5C9syoBkQ9ks1HH0M
         dlfA==
X-Gm-Message-State: APjAAAV6cz/MEvu5J2/pjWA8RHv1wHSb3eyJxFNlKWI5cPWxKYLq9S+i
        hKnKjHk1IxYlDkIFSlcOIDY=
X-Google-Smtp-Source: APXvYqwMKe4kUhbmqrhzGeJU3YnHO6wYl9UjKxkT1wrIQ6Yam19y77XrTS8FzO1pKIASH4l19LKEqQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr15914955wmm.1.1577386346270;
        Thu, 26 Dec 2019 10:52:26 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j12sm32129352wrt.55.2019.12.26.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:52:25 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] RTL8211F: RGMII RX/TX delay configuration improvements
Date:   Thu, 26 Dec 2019 19:51:46 +0100
Message-Id: <20191226185148.3764251-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In discussion with Andrew [0] we figured out that it would be best to
make the RX delay of the RTL8211F PHY configurable (just like the TX
delay is already configurable).

While here I took the opportunity to add some logging to the TX delay
configuration as well.

There is no public documentation for the RX and TX delay registers.
I received this information a while ago (and created this RfC patch
back then: [1]). Realtek gave me permission to take the information
from the datasheet extracts and phase them in my own words and publish
that (I am not allowed to publish the datasheet extracts).

I have tested these patches on two boards:
- Amlogic Meson8b Odroid-C1
- Amlogic GXM Khadas VIM2
Both still behave as before these changes (iperf3 speeds are the same
in both directions: RX and TX), which is expected because they are
currently using phy-mode = "rgmii" with the RX delay not being generated
by the PHY.


[0] https://patchwork.ozlabs.org/patch/1215313/
[1] https://patchwork.ozlabs.org/patch/843946/


Martin Blumenstingl (2):
  net: phy: realtek: add logging for the RGMII TX delay configuration
  net: phy: realtek: add support for configuring the RX delay on
    RTL8211F

 drivers/net/phy/realtek.c | 59 +++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 8 deletions(-)

-- 
2.24.1

