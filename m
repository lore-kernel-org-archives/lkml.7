Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B9EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E0D2465B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkWu6RaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfLMVbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:31:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33961 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:31:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id l127so354565pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Aoa28kdUcAmXkadH+8rqcQQ18pmnTzWmZZhMobYYD+4=;
        b=JkWu6RaXpVRwOEblMcd37I3qroMQhLh/u/xUYxznodN69LHmnOp5skkokX9kDmvstr
         CFTy1LX1y79sJ7EKdkGpNJKUKqOOGsDCqvcIO0dqC3sKqoPFzVn/mSxYQV/XR7bMYefo
         xfVDU59WbjSXvmrhJ0raiBlKaLNqxKdWQMRMQcym6gyQqTA1aiFaa4VVEIKg7BszNT66
         30vqngGcZz8ysHl+DYempCHmAouBT4bZt1VWC42dgN5jul/XB6PHf1rUrVs+zxqP4zOB
         47lF51Ciob2T6N6dglyQWvTCA/EU2brfzqnGQSxg1PGqmYvvdM+uR5AyiCiYdYW+i6/k
         1q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Aoa28kdUcAmXkadH+8rqcQQ18pmnTzWmZZhMobYYD+4=;
        b=EYSDQWXGYr2C4aWx6X28UPNX01PBYeJR2ZbXcEGCuddr1tbb91j5ufyetIFRy6TZ/B
         HGR7WRS4mjqME/hpKRLCoQ8/z+EHwv6oTEHmEUdKsVHC7zCaTLZaxokXdI+rd9zavMnx
         2xBHkAMiEjs+gDr65h9YClyANh3KsyCrVKsYk1gjOcmZXX7UBp29CTm6cwKiaqlaU20Y
         Zo/u2VqiraV/Yt/20+uPrd+h4p9YkHUJMyeq348Ff3wlY6NsStLwouB6aGRa+TAxqv0H
         OdhtO4OjAVKtrnYxO+r8vE7sRVJgkSsXA5WWywQGcdyHRKLDk3geJJqJEaqwTfBIxtYs
         q97w==
X-Gm-Message-State: APjAAAWEoWyeWwIzkGn249SoagxDQhqnMEB+XGCqLXGRolz5vJXU8AjU
        Km3e8P2CyJnfwKSh1JKU3grhfQ==
X-Google-Smtp-Source: APXvYqwGdSCR/KBedKamWASBniqZncBVw701nVHyxvuCmpab0i/gfWrNh0nB5yrNdv9raGXeYgtNng==
X-Received: by 2002:a63:753:: with SMTP id 80mr1653743pgh.95.1576272707558;
        Fri, 13 Dec 2019 13:31:47 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e16sm6847003pfn.59.2019.12.13.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:31:46 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:31:46 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
cc:     Erdem Aktas <erdemaktas@google.com>, Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [patch] percpu: Separate decrypted varaibles anytime encryption can
 be enabled
Message-ID: <alpine.DEB.2.21.1912131330150.51759@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

CONFIG_VIRTUALIZATION may not be enabled for memory encrypted guests.  If
disabled, decrypted per-CPU variables may end up sharing the same page
with variables that should be left encrypted.

Always separate per-CPU variables that should be decrypted into their own
page anytime memory encryption can be enabled in the guest rather than
rely on any other config option that may not be enabled.

Fixes: ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/percpu-defs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -175,8 +175,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
-
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 
