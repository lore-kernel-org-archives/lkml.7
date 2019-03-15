Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E82AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F4E2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="J54zJ/dB";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="J54zJ/dB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCOVyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:54:41 -0400
Received: from node.akkea.ca ([192.155.83.177]:35116 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCOVyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:54:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id EE4064E204E;
        Fri, 15 Mar 2019 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552686880; bh=9N4biJJEaFKsuJVAaC7yDIHSjDYZ5bi0hQQsogDxEak=;
        h=From:To:Cc:Subject:Date;
        b=J54zJ/dBpwZe/D63inu9R1RXLNaBET+ZUU2iYn5WmpBbHK2GCQk2Kxooz9ZGsHBiG
         GRqp5gW91aQQjQvVTwFNUxxJpMtKG90oGMbedld2v3JmLjTLN1k5yW8LqGz+I9dGHC
         DYu+obkzgYq7zd+s2OU8CN2SGBY1NHAEpXuOpfw4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y5A_wlA3Ohio; Fri, 15 Mar 2019 21:54:40 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id C809E4E204B;
        Fri, 15 Mar 2019 21:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552686880; bh=9N4biJJEaFKsuJVAaC7yDIHSjDYZ5bi0hQQsogDxEak=;
        h=From:To:Cc:Subject:Date;
        b=J54zJ/dBpwZe/D63inu9R1RXLNaBET+ZUU2iYn5WmpBbHK2GCQk2Kxooz9ZGsHBiG
         GRqp5gW91aQQjQvVTwFNUxxJpMtKG90oGMbedld2v3JmLjTLN1k5yW8LqGz+I9dGHC
         DYu+obkzgYq7zd+s2OU8CN2SGBY1NHAEpXuOpfw4=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Brian Masney <masneyb@onstation.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>, ryang <decatf@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add a VCNL4040 light and proximity driver
Date:   Fri, 15 Mar 2019 14:54:23 -0700
Message-Id: <20190315215425.24140-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Vishay VCNL40x0/4200 driver to work with the VCNL4040
chip.

Angus Ainslie (Purism) (2):
  iio: light: vcnl4000 add support for the VCNL4040 proximity and light
    sensor
  dt-bindings: iio: light: Document the VCNL4xx0 device tree bindings

 .../bindings/iio/light/vcnl4xx0.txt           | 15 ++++
 drivers/iio/light/vcnl4000.c                  | 89 ++++++++++++++++---
 2 files changed, 91 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt

-- 
2.17.1

