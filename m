Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF1C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D756920866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578006007;
	bh=4X3EMyJ0yJG6dcvF3YVvO9otDvVgBRj4flXFT3gicCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h76WMUeo8FL71SoYDy4EoZ7KM0duMiRu6wyK3Ls9a9ciMma6A+C8M6gVeZqMejC+w
	 /kRWT+iVBfGoqOkfwyK3TgyJmftOMFlp40lqfTkmxjxEZNbfxLFYPuQKIy3pQcdKuh
	 ZomuA567JDFvO2BqYaOkpzt+imrl+T3mFtC0ClI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgABXAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgABWN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4512253D;
        Thu,  2 Jan 2020 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003206;
        bh=4X3EMyJ0yJG6dcvF3YVvO9otDvVgBRj4flXFT3gicCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5Hm7LgyowJIw9aJSBS2D0KXaz13pqz1pTC4ZbL892gyikYYDn8g71FfYT1+fgxTh
         dWoA3mByAwVuJIiaKfXZRRQJbmpb4Ph+ijU0OaOplTI++4n6w85lfDAyy7cQBA256m
         IfwM4H7uueNJIY5TeFZJhszdA4TN6oIHqGYjr0KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Modilaynen <pavel.modilaynen@axis.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/191] dtc: Use pkg-config to locate libyaml
Date:   Thu,  2 Jan 2020 23:05:20 +0100
Message-Id: <20200102215834.015953905@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Modilaynen <pavel.modilaynen@axis.com>

[ Upstream commit 067c650c456e758f933aaf87a202f841d34be269 ]

Using Makefile's wildcard with absolute path to detect
the presence of libyaml results in false-positive
detection when cross-compiling e.g. in yocto environment.
The latter results in build error:
| scripts/dtc/yamltree.o: In function `yaml_propval_int':
| yamltree.c: undefined reference to `yaml_sequence_start_event_initialize'
| yamltree.c: undefined reference to `yaml_emitter_emit'
| yamltree.c: undefined reference to `yaml_scalar_event_initialize'
...
Use pkg-config to locate libyaml to address this scenario.

Signed-off-by: Pavel Modilaynen <pavel.modilaynen@axis.com>
[robh: silence stderr]
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/dtc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 82160808765c..b5a5b1c548c9 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -11,7 +11,7 @@ dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
 
-ifeq ($(wildcard /usr/include/yaml.h),)
+ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
 ifneq ($(CHECK_DTBS),)
 $(error dtc needs libyaml for DT schema validation support. \
 	Install the necessary libyaml development package.)
@@ -19,7 +19,7 @@ endif
 HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs	+= yamltree.o
-HOSTLDLIBS_dtc	:= -lyaml
+HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
 endif
 
 # Generated files need one more search path to include headers in source tree
-- 
2.20.1



