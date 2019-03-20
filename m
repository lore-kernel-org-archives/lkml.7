Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AAE218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etHOVhrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCTWnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:43:51 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:54798 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:43:50 -0400
Received: by mail-it1-f178.google.com with SMTP id w18so1515423itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmX3vzoG4RUO05+cGwbQv31ZhYYKXr856hwJ08EHbTo=;
        b=etHOVhrnpjei8FNbjtSdLSWFG6eh+FRRkpbrA1OYq4vkm1ki/HiYEj/B0LQ1+XTTbf
         dzac2UC54DHMrxDjKB9fSP360HrEfQhvVR16m9Ru251yXXlXb3HUgPAU1e92fVUAXKls
         XKlGwhfcVm9TT5qLyMx+Ka42abfyvWitGpMlX7cwHVojOH03LYGSy3p+4zlbVA/ku+xW
         YLcAqSR0zayQMSltngT/zYmGK3TE0Pne36nq5esLj1EfvpEY+iNMTezGilWgscZEZbdO
         ofYrk3Mdz5YkqoWyJg89iihaWFEeAeu76B5o36W+PwlFSbWWq0yfAu/lBnFfpIEVaQ6g
         P9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmX3vzoG4RUO05+cGwbQv31ZhYYKXr856hwJ08EHbTo=;
        b=THdQobvYhJlOVls3y8rhy6lxtPSVAzxjSBXuRQDBKEr6TuXVKM/lNvOmTsTZuMEMqN
         9wNp7t40ZANC3zGqhsPsDeYOY59p7zahwtCOVmuDdZAuVGdSoIcuzJ87WtjGzkA1PfH4
         peBeR2HoUSnLG6YvjTm/U4XnpX2uxp/d/4zEG0Ck4EapWaNFqD5zk76OkjIAQKsKFt31
         IvPD5Ly10DBwbxXwUkKIIoVNCgobwW8BosxrvhtJJGHCVUZDCdOExecCiDTvGCnl6SEs
         bpTwQuwXm3OAOFVAUb160+uRRXpWFD5XLnimVXQN89ThiLKBDL9dIc9yFQPMUW/dBiRJ
         PVNQ==
X-Gm-Message-State: APjAAAUj/kwKoUJy0L8iey/7aUiPwb4XaHo9B+8tR17vHdcGhGM5R5Nc
        MzEf4Glp2PY45wC3+SsXAHk=
X-Google-Smtp-Source: APXvYqxC6BVNzodCJrcyVDqpJki02TWiYhHVC/5RpPbdrzIoTgbgp26+zLGgQBe6lGwMP+JyeEqw2A==
X-Received: by 2002:a02:b803:: with SMTP id o3mr535404jam.142.1553121829426;
        Wed, 20 Mar 2019 15:43:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id 139sm1805554itk.28.2019.03.20.15.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:43:48 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] mt7621-mmc driver correctness fixes
Date:   Wed, 20 Mar 2019 16:42:02 -0600
Message-Id: <20190320224204.10243-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves up the patches that needed more work from v2 I sent
a couple days ago.  BUG_ON()s have been removed.

Let me know if you don't want the 'Remove obsolete Kconfig flags' patch I sent
in the previous series; I didn't see any mail about it.

Thanks!
George


