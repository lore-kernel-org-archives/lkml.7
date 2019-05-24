Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DF2C282DE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5487A21855
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzVi6jzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbfEXBBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:01:43 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:50706 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbfEXBBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:01:41 -0400
Received: by mail-vs1-f73.google.com with SMTP id e204so1591477vsc.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2KTzGfh7kv2d74sdNHCbcBSbV7diWdzXOMvg7FHNFO4=;
        b=mzVi6jzFMqv5OndYo44UnYwAhp/A1s7mSJixeVtrzL1SVdbFUMPmss/UpVBpcK2mc3
         6JpipzeOt8PNkpGmfs/KNDBwojsxWQhnbvFSWCPvODpQxqnwNZvuphHTsiZuxW+hWTs3
         90uA475RD1L9eUFxtVZS2p1a28mz80YhxFcg2EDFAMIgCM9kY7aGY/LD9rj0H7NjEWBP
         kZ03tZrj5JvYHanoyWT+MuTKJl5nzc6Q8Yoj5GWgpk1ntNX3rOqhNCoS5n2fD2X1WJPE
         JQSqb6guVKK+BSJNK+xqvFKlu2iLmlh/Rgs6eB/nDW6YPTBjwQOliV0UVVIbJRaj6XLr
         WiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2KTzGfh7kv2d74sdNHCbcBSbV7diWdzXOMvg7FHNFO4=;
        b=tHEZ+/mNb6jR3Rc7evw75pYAdIu3xrdWOZNZqEACu2uc5OtVNjbqhgh2mdmvCnKuFo
         sxehACMhAEe7mY5Tl7WxjEryftltuLtr8pzcDyslwLRTV7iI8JVZxxBQPTvHVwl2mhME
         wNUUKPKp5CW5a6xpcmg5MYngLnFyTuxb2EfVPRnTkWUDC5HGE2/AtWPb99f8K2FTyRy+
         K+krU862ZSDgVd/ZvMDD5nbywvFKntNBNPCJJLc1r14C3/QrU9Z1y3GxRYTxhQe1C6CW
         1rXhn61gOlhlpwdm2CL37QuqrcZqrI3MTL7nPTGrAJZ1+Q2X918aRD+TqwIeRLWVcVC+
         FA+A==
X-Gm-Message-State: APjAAAXo2ku60QEmLFRWcsR/13cIgHJA+K7UI7NtCKcQ7W13J3BCa33i
        8CKAt2puWp3VW6yL6RdUrlv/s1MVVLXjTwI=
X-Google-Smtp-Source: APXvYqz3L5Ny+w6SJ7GS9eHpSyOf+EVWWxK+Na+47yqMyNdh8ZCYTywstEDHIokigMpxHNxEpiqQ9fjd0jfnbV0=
X-Received: by 2002:a9f:3241:: with SMTP id y1mr9499048uad.107.1558659700238;
 Thu, 23 May 2019 18:01:40 -0700 (PDT)
Date:   Thu, 23 May 2019 18:01:14 -0700
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Message-Id: <20190524010117.225219-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v1 3/5] dt-bindings: Add depends-on property
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The depends-on property is used to list the mandatory functional
dependencies of a consumer device on zero or more supplier devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../devicetree/bindings/depends-on.txt        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/depends-on.txt

diff --git a/Documentation/devicetree/bindings/depends-on.txt b/Documentation/devicetree/bindings/depends-on.txt
new file mode 100644
index 000000000000..1cbddd11cf17
--- /dev/null
+++ b/Documentation/devicetree/bindings/depends-on.txt
@@ -0,0 +1,26 @@
+Functional dependency linking
+=============================
+
+Apart from parent-child relationships, devices (consumers) often have
+functional dependencies on other devices (suppliers). Common examples of
+suppliers are clock, regulators, pinctrl, etc. However not all of them are
+dependencies with well defined devicetree bindings. Also, not all functional
+dependencies are mandatory as the device might be able to operate in a limited
+mode without some of the dependencies.
+
+The depends-on property allows marking these mandatory functional dependencies
+between one or more devices. The depends-on property is used by the consumer
+device to point to all its mandatory supplier devices.
+
+Optional properties:
+- depends-on:	A list of phandles to mandatory suppliers of the device.
+
+
+Examples:
+Here, the device is dependent on only 2 of the 3 clock providers
+dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      clocks = <&osc_1 1>, <&osc_2 7> <&osc_3 5>;
+	      depends-on = <&osc_1>, <&osc_3>;
+};
-- 
2.22.0.rc1.257.g3120a18244-goog

