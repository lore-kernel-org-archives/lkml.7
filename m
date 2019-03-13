Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B39C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VmooRa7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMRLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:11:43 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49318 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:11:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 853E973B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b4dZrjKsl74O for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 12:11:41 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4D29DB67
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:11:41 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id n15so2083050ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0tTUa8FUUdELgiORXzwOG0CWuGm825H00lI4rsbun2M=;
        b=VmooRa7kDLo7sc814RzDr123GARCVKEkKcSA1lQebp2UpG1SQfxUPoutDQwb3Dw4QS
         mXMTXvTaPs6RkLVcDWN9PMHzhLj3Vur4GVVDOJUwEfC3OGmpZR4M7yyiJaZ+duZRHwh/
         o+DiUkU1XkpEUFgt+fB8Nk3/sCGgZ7lFiddoydFow62r9RRnmtJ7484zqCh73U11h+tQ
         /m7FE8UDrzWNbG18EU748c1JeMBPSmELDL5Y7on+hqSl/1sQOO8tP2hJMxtOXTW+okdx
         O2/IEx7WZYG+XNgjwXMDRQKjk4GBNohsp2oxjXDI87iIj9oiaxnCeIb3j60lH7nmUcYp
         4ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tTUa8FUUdELgiORXzwOG0CWuGm825H00lI4rsbun2M=;
        b=OkrI/ajw7BJsXp1NTLudc875LzhPYlgTOctsgnH9OWJOBKWOSV9MWUS00bxCuem+kJ
         o0MwMuAzyEb8ex4y5iNTuizUDS0Uc2QWYHeqiNlJELWfyCiLkw66o/vIiBE2QHHt75YS
         bWAZTa0EmKXwnRxJKbaQwnXBocDkdlVNtW3iAVbYs51ywSsw62/5F+zVzxSceyMuHlNM
         aJxoIgI9nAYz3Lxaup8GvBzU+1WMhKarIVDisbFLZgDa2U4ynFIlEsn10Ra/qxW2FVke
         NVFTbMmIB302795kNfca+SkluE7IXH76+HsAu45Z8CMmNTOgWogL4eEBsRV2hPYTr3jX
         Aolw==
X-Gm-Message-State: APjAAAXG+afzd+qQd7KNoLzqboP+rJcDXXX0Pt9jPGtRnpMpKpfFD8V9
        gLDrUrRykwK+rf1W5x+GWiEcAUWxqQPFLQC3jLTssP2j932RTEwnU9us4+OBL0Y3tQ5801l5e+A
        KtjmqhjpdYJoSCGzuePYOvbQy+/12
X-Received: by 2002:a5e:da0b:: with SMTP id x11mr8328676ioj.200.1552497100762;
        Wed, 13 Mar 2019 10:11:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTKUuxsBWd6LMAp56rBfjm3+cvGYI5C6MtMIAJizKHyW/Si0897CqC66WoUoXvun1YI03phw==
X-Received: by 2002:a5e:da0b:: with SMTP id x11mr8328660ioj.200.1552497100547;
        Wed, 13 Mar 2019 10:11:40 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d135sm1430958itd.43.2019.03.13.10.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 10:11:40 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: Fix potential NULL pointer dereference
Date:   Wed, 13 Mar 2019 12:11:30 -0500
Message-Id: <20190313171132.23052-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwxmits is allocated via kcalloc and not checked for failure before its
dereference. The patch fixes this problem similar to rtl8723bs.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 1723a47a96b4..a557ed37923a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1512,6 +1512,10 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
 				     sizeof(struct hw_xmit), GFP_KERNEL);
+	if (!pxmitpriv->hwxmits) {
+		DBG_88E("alloc hwxmits fail!...\n");
+		return;
+	}
 
 	hwxmits = pxmitpriv->hwxmits;
 
-- 
2.17.1

