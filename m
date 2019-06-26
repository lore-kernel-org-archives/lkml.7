Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA371C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53A1205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFZKh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:37:57 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54484 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfFZKh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:37:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5BFE2FB03;
        Wed, 26 Jun 2019 12:37:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hqCczjRyAxuN; Wed, 26 Jun 2019 12:37:52 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 77E7048EAB; Wed, 26 Jun 2019 12:37:51 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH v2 0/4] drm/panel: jh057n0090: Add regulators and drop magic value in init
Date:   Wed, 26 Jun 2019 12:37:47 +0200
Message-Id: <cover.1561542477.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the omission of a regulators for the recently added panel and make sure all
dsi commands start with a command instead of one having a magic constant (which
already caused confusion).

Also adds a mail alias to the panel's MAINTAINER entry to reduce the bus
factor.

Changes from v1:
* As per review comments from Sam Ravnborg:
  - Print error on devm_regulator_get() failres
  - Fix typos in commit messages
* Print an error on regulator_enable()
* Disable vcc if iovcc fails to enable

Guido Günther (4):
  MAINTAINERS: Add Purism mail alias as reviewer for their devkit's
    panel
  drm/panel: jh057n00900: Don't use magic constant
  dt-bindings: display/panel: jh057n00900: Document power supply
    properties
  drm/panel: jh057n00900: Add regulator support

 .../display/panel/rocktech,jh057n00900.txt    |  5 +++
 MAINTAINERS                                   |  1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 44 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.20.1

