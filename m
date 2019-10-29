Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD16CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6A52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVu5mhpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJ2XWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:22:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42470 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2XWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:22:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so611550qts.9;
        Tue, 29 Oct 2019 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RIHrM2T5t2yjqxj2JPTS71DBT+0RqAHHijTzNDzZvQ=;
        b=oVu5mhpbwaYDhSZVWLJHva8w1r3fWnI9tbf3bI81Z4kUpGcBcb2LQwxgA6rQyaaywy
         EDQZOJBJcBKsDP3+uO4LLxe+AJF9/wVa3YgYytzy/IOYHwXeAIrHkoOp+sizz3UyROHV
         84hjPfNn2mik6aS9KauqQptgafjsGlQVFQPL28vR+jYxSWLy0kkwodlH9evs0l69znCj
         ya1lmfDMy9OnxY0ecCnUtlUZaCfVcU0iKHC7XToeqpR32y1271NCKeA2+NVwK9r8Z9Va
         Jx8bR9zQ4AsSLF6bR4tzex2O8jvJjY+avCUTU6ELAV3OVxzap4FhFChnHUyeRy6fV+6w
         r9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RIHrM2T5t2yjqxj2JPTS71DBT+0RqAHHijTzNDzZvQ=;
        b=Z4meGqKylltw3rWMkhJwbqDdfJddxqJUS5puquka5QUNYnqXNMKl/YK8C7US1Li7vi
         k7pVGZRPnx7LHXrFze1LtfRqCYsPxGtUPAuJaXetf9GN3FPpilBExPiiIDA0iMz5BJ3p
         Yk1XUyqBbzPo2HRCBl2YgBrIxaxLLXl2a5AltOiKW46sFhwvxlCt+qzySg1GASb0xT67
         mr4xksWPct5R/34jdGPl+lpHud3dOS+oaDY61gjr1uaoI1heS+8ZQZpu3C8nMaoGeAVX
         llyZKgzqq7xajJTPAs2wwQZR27DmN/j63axRDsHwC5HU7VHSy10Q7b9ghp5LA7+oyIQV
         A1uQ==
X-Gm-Message-State: APjAAAWuzuP1VWurUc21OfRZME2HAC9MZILfzRcpu/FQEjS1aaaPEfkG
        G/D66eTZ1hsV6FbWrdfpP4Y=
X-Google-Smtp-Source: APXvYqyVtKZdQakEpy7jyH1XhEBn63IFkrC8JPdYR9oGo7S3PD9dTfWcVsiu9qgGrB00b2JedWkISg==
X-Received: by 2002:ac8:6146:: with SMTP id d6mr1980022qtm.271.1572391337209;
        Tue, 29 Oct 2019 16:22:17 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id a18sm633940qkc.2.2019.10.29.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:22:16 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 0/2] staging: sm750fb: Fixing codestyle error                   
Date:   Tue, 29 Oct 2019 20:22:05 -0300
Message-Id: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing typo and usage of spaces/tabs in file sm750_accel.c

Gabriela Bittencourt (2):
  staging: sm750fb: Fix typo in comment
  staging: sm750fb: Replace multiple spaces with tabs when it suits

 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.20.1

