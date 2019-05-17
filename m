Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70235C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C1206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lr1hshRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfEQVjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:39:23 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36032 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfEQVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:39:23 -0400
Received: by mail-vs1-f73.google.com with SMTP id i13so1670697vsr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=Lr1hshRLI8bkkP5XQ+UnqbvtSIn4+GxIHNrUKo5knOvGtLVWvllhbmL/P7SFVq0q3G
         oySlkP3VC/FArrDJIA9lERGu11efUk2HE1iv+rtqxt5h25S7olLYbSifqxp2Pm5Sa14n
         eJG55mOsEM7FGWG36vVTPIvS49vJRvB2AnCjRfPc+2yd0Vqq9usi7KTHCKhCd0IyT4PR
         qBfAxm/5OnPt9nlgrr+zu3mJDsmaWzAe27XN5d6ZwKQ4qa8VeYXAmd15kiS/0jyawOr0
         9nYCnuQt/oEVdCzXELQw2AWQANdTpFx0IkvBjyPIam8tKwuieV42gWQlnehz57Ep/F18
         7Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=Y7JkoISbJKrtupcdZi1VFIcYZp1RufzawbwBeT+sQkJyHCmYvnBKTx9a7KmheBpTjn
         k3Awl6k0mAyx9TXPwPDa/iEEKFc88xmoWgwalxUSVHeICGEGyjQjlNsqAd3BeVkSPt+S
         l8PEn/762+u4hB8tsECSXlTSr6kcrL2d4u/rZ1KimWX+lEYZvzSLFM1QmXr00Mm7VMm8
         uZfT5eAu+JMT/m2iUSERLcHscr/XJ8UEnGiQfAVyjDTGNEltqBiIzQzY3/cHjBmETdT6
         H3PO2DtS1f3iOZLv42gKRpw5vquZhQMsrseatiexefRrv01C8kEBQ/+89u+u3h9+/CZ2
         vuJg==
X-Gm-Message-State: APjAAAXZyowiaN+gpBUiHA/oQ4NzpgmjgLL4hCMH5u3Eal6Jj0qQuQyu
        FylYOe7R0vu5E5hgo9ZpzXNaafrhafFytImENxwgSw==
X-Google-Smtp-Source: APXvYqwIDbPWP1gGpGqX0HDPWX3Ohrqk6UfCTZUEHeW8kUGSBX2WSMELoI3iXY6X+cwOujb0YKqTVixq1iTSqpDOz3RSCw==
X-Received: by 2002:ab0:5a07:: with SMTP id l7mr22035272uad.78.1558129161944;
 Fri, 17 May 2019 14:39:21 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:14 -0700
Message-Id: <20190517213918.26045-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 0/4] Add support for crypto agile TPM event logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated with the fixes from Bartosz and the header fixes folded in.
Bartosz, my machine still doesn't generate any final event log entries -
are you able to give this a test and make sure it's good?


