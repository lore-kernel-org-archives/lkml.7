Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9FA2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4Dup9uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDIRYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39352 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDIRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so9688086pga.6;
        Tue, 09 Apr 2019 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KzE6pQkr38YFZeyJkyYMlCVCFIA7T3NhcogtQq7roUw=;
        b=i4Dup9ujLGmWudqLS6JnGWF7SuxlKMqjS6pLFL1T4MnuNe4eCpoMrhOFOByuwyXJo/
         P4ZAh45JqgstUAjn0kov6on4+8QIiq/JYPyxqeq0Y/YPA5HWrg/7oiBH5EAFgr5grGIP
         zg4mxTdUB7BopHuZuojBPtUnhvjzEPmOihPjVfJRNF9maKhmdgQUITlOu7Wc9SJJhyy1
         +eIrDN6Z1QxZMRMEq7g6imODUSuIN47dZjPwYjp0/FhZk9doKr+OTpOL4b8YnxIz+hC8
         ysL174u0rNJs86bG2dh5oROXrjTmGZb75FX1gsfvv4XQq74fDQPz6j3yTATNR/v4yCCu
         r3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=KzE6pQkr38YFZeyJkyYMlCVCFIA7T3NhcogtQq7roUw=;
        b=ZU+FLfxYQPDnzff7gITlc0M5GrYg8I329PihW2264rIuV9L71AnhuLFo6IFJVhIYyz
         vdozFnjoC9aUDt4MciiYzPIo5INOZNUtMW8L8+Djp7h/lGd+0oAJR4l9+h2X7DIdZsPp
         9y84633hJdddxw9ftDthydv+ZYWkt/b9nrmVa7eZ/404sXMJa12Tt+Chn0nMg7RzGTMA
         i/Q4G9yI8zoWSo1Bh4g7TamYc6e+tRGV18tKlW5BUbTp6J3NGkVIbtXwaQxsuT3kHM/t
         Y3Udf15/fesiy8SliZxFDITVi+4b+e7OboJGcnpVz73HueWFdAStUHFrnHAcJWGAqNm9
         h0hA==
X-Gm-Message-State: APjAAAXBkxL4TX/QgDv+fy2x/tuVBwzOVftXWMOgoOx7iwOO+AnEJqVm
        OfTRTOGwwCoC9PaA8W75kxyWnTEP
X-Google-Smtp-Source: APXvYqzgFpm4dDRv2ZFmwC7RJ9EoI9zv471Y+NYdeLIAVkj1QAGuL0siw4OwgEO4bB3mouMkbe46qA==
X-Received: by 2002:aa7:9392:: with SMTP id t18mr38203831pfe.45.1554830651854;
        Tue, 09 Apr 2019 10:24:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm54172681pgx.68.2019.04.09.10.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/23] watchdog: Expand use of device managed functions (series 2 of 3)
Date:   Tue,  9 Apr 2019 10:23:38 -0700
Message-Id: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions and other changes to simplify error handling,
reduce source code size, improve readability, and reduce the likelyhood
of bugs.

The changes made in this series can be summarized to

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_watchdog_register_driver() to register watchdog device
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Drop assignments to otherwise unused variables
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Replace shutdown function with call to watchdog_stop_on_reboot()
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'ret = e; return ret;' with 'return e;'.
- Use local variable 'struct device *dev' consistently
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Drop unnecessary calls to platform_set_drvdata()

Conversions were performed automatically with coccinelle using a number
of semantic patches. The semantic patches and the scripts used to generate
commit logs are available at https://github.com/groeck/coccinelle-patches.
All patches were compile tested and manually reviewed.

This is the second of (at least) three series of similar patches for watchdog
drivers.
