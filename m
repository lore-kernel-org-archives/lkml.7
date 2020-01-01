Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DDC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B7207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pCxOBBMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgAALZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 06:25:12 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:34274 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgAALZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 06:25:12 -0500
Received: by mail-pj1-f53.google.com with SMTP id s94so1308609pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xjl26WjVPVTED+/xAzYPIrEiiwgVbZ+1Lffk83rGuXg=;
        b=pCxOBBMQfuNezDx4YUqo3tQFY05m/gmgb6vvLxTF1ZUJ9v4q6PEKGVmPi2bbETWWhT
         pzFB4Tb9qeC4RQfaf0V5Uxb+jdQSpJg5E9QYSfKS3pOf0Z7ev/fLwfGEDFiEe0jE/q0u
         OgCyU8qt5jPl38RFDgBoFS7stpw5HIzC4VgDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xjl26WjVPVTED+/xAzYPIrEiiwgVbZ+1Lffk83rGuXg=;
        b=Xwpf2q2gN6iq393mGIYb7w0v9DjQIBCxNlBR0JYU5EUloJBKM14Nwf29rO+SQ5CvxV
         7r/eZ6tYR0Ut30m/qp1+e76bWiuQPiubhioPJi95qkmD17DgJYFrWzcBs0/EXw0ATsRi
         vn6xOdQoFK0JRRi7kYe0bgM1ZAC13QI05TCvZWiaBS9bcPY15kBs5Cp7kph4s00Hta8i
         8XdOUN12DH43QpesoffLduAC6axOMZpv1pxy1WyMFLTIFz6zuVfEidMSYsWFAZX4WEJ2
         WHQrk1V+F+3mNCAIy9r/+QDP0I56Sp2L5U6P37yoQo/7NswlAv2ZYwdIGgK4n+G0Jr0N
         QXbw==
X-Gm-Message-State: APjAAAXDfvqMybN+yde66oCIleCewEZproSEvauPVKp15VLZlCNslNZ4
        xf9vwgjJlWzP6eEPJljCtYS9AQ==
X-Google-Smtp-Source: APXvYqzpUhwfAbGzLwKIL383B6Symz9HyuWU2vN+KQyIbBQzrtLHY7UohuWPzGTkdsMfQfTFtGfikA==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr13658293pjp.116.1577877910967;
        Wed, 01 Jan 2020 03:25:10 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d0fe:8978:1b04:ff94])
        by smtp.gmail.com with ESMTPSA id y7sm51945439pfb.139.2020.01.01.03.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 03:25:10 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/6] dt-bindings: display: Update few panel bindings with YAML
Date:   Wed,  1 Jan 2020 16:54:38 +0530
Message-Id: <20200101112444.16250-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These panel bindings are owned by me, so updated all of them into
YAML DT schema.

Any inputs?
Jagan.

Jagan Teki (6):
  dt-bindings: display: panel: Convert feiyang,fy07024di26a30d to DT
    schema
  dt-bindings: display: panel: Convert sitronix,st7701 to DT schema
  MAINTAINERS: Update feiyang, st7701 panel bindings converted as YAML
  dt-bindings: display: panel: Convert friendlyarm,hd702e to DT schema
  dt-bindings: display: panel: Convert rocktech,rk070er9427 to DT schema
  dt-bindings: display: panel: Convert koe,tx31d200vm0baa to DT schema

 .../display/panel/feiyang,fy07024di26a30d.txt | 20 ------
 .../panel/feiyang,fy07024di26a30d.yaml        | 50 +++++++++++++++
 .../display/panel/friendlyarm,hd702e.txt      | 32 ----------
 .../display/panel/friendlyarm,hd702e.yaml     | 47 ++++++++++++++
 .../display/panel/koe,tx31d200vm0baa.txt      | 25 --------
 .../display/panel/koe,tx31d200vm0baa.yaml     | 37 +++++++++++
 .../display/panel/rocktech,rk070er9427.txt    | 25 --------
 .../display/panel/rocktech,rk070er9427.yaml   | 37 +++++++++++
 .../display/panel/sitronix,st7701.txt         | 30 ---------
 .../display/panel/sitronix,st7701.yaml        | 61 +++++++++++++++++++
 MAINTAINERS                                   |  4 +-
 11 files changed, 234 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml

-- 
2.18.0.321.gffc6fa0e3

