Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E9CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EABF21D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="tLNICXL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfJSKJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 06:09:19 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25470 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJSKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 06:09:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571479746; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VYWEkVUxzQsMvEpvVJp6tvF1x3aj4gwASVCAIC1y9BSAduwHCOgufuaJmdAmxOAtsExv3XemkuC1dEBOnRU+zwfcPCgl861K2YEk7gyokcTqzZB/SWIvG/XHux8Fk0E9hMTQlgYqNV7ivzaGZMq3nlQfFaBQTizDgKBOp7zBdcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571479746; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=dvfTK6kVeJKRxeJGL61f1+aGjYpZxdw1hrHuyx+0Vcs=; 
        b=GMvKYpo5rvJJg70Et6aU5X1aBDT24Q3h9HGyNhBMBcpBf+1rx2azJtg0mgLtAo8kddxX0XWu72e8VPDhG47gFmfdlxbWTR6a4iE2eiQX30OUdBq77Q5vmwkZrxGmDVbcUGwL3H9kh34wW2MRRCGy2Uzfpoqm+mol3TyfJ7wzIkM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=TKWoavtXZ8e7ugaswr75mdJSrk8Rv7fFczhyYV8chR7WjhDOKD6lQHLIaFeAf9jRNRVtfzACj0QO
    +qwghgRI2DNqA8iBVaZ5/nJrBqr5hMIFCG2E8ROeQrsjbaczHhdy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571479746;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=128;
        bh=dvfTK6kVeJKRxeJGL61f1+aGjYpZxdw1hrHuyx+0Vcs=;
        b=tLNICXL2wdI88TP2i8QjwRS9WNFl9aLUcYWrmryrO/0V9MtgHFExfwbOEoaeglBl
        md/XjmLYafs9nyFl7xgwtiWFhGAYkCs8gclRkfIPlVQ+fQYY3Qi/xH7R/EMmCAcj6lk
        1X7OKWwzeTi7sd/ZVy4Zs3DqoN35qxz2axsivewg=
Received: from localhost.localdomain (171.221.113.199 [171.221.113.199]) by mx.zohomail.com
        with SMTPS id 1571479745260262.45412969470283; Sat, 19 Oct 2019 03:09:05 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, sboyd@kernel.org, mark.rutland@arm.com,
        syq@debian.org, mturquette@baylibre.com, paul@crapouillou.net
Subject: clk: X1000: Add support for the X1000.
Date:   Sat, 19 Oct 2019 01:50:04 +0800
Message-Id: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the clock bindings for X1000 from Ingenic.
2.Add support for the clocks provided by the CGU in the
  Ingenic X1000 SoC.


