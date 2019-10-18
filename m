Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FECA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A17E222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9MS2j9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394997AbfJRFYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:24:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46170 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbfJRFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:24:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so2257990plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3o3EqRq3PgsgiQtn4AY+sfKyKLaEqB9pO5QeXjYW1YY=;
        b=x9MS2j9SeTU1yjy/80Wvue6xeCHSErdf9EALM3Tjzc+ohSUTFrZ70EJyB/p3y8uCmp
         E6oisSzZ64R/uT5q9VScB/CUyOZ7ZGyvBjpyp+JPl3pGOKo/IXykFV388A0MvXI77cst
         pX5J3+EwmNbRsR9dCClbr9xz+PMxp6zkgcXjXyQuncbUYaCKC4ppDkibNqRVoiKxoeeH
         +oLDcz/9+Kcji/s4z+0T7kT4MnasCEasJtZh74m8B8wBqkjOwDpK8JzeJNlW3UOJuHVG
         pt2vWbvQc3jWMwz2Ms+vvdBzlZUx/NjpKlQsWPs7KiSDmoqv7lUg/7KxWmUlBYxRTjrF
         KBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3o3EqRq3PgsgiQtn4AY+sfKyKLaEqB9pO5QeXjYW1YY=;
        b=XcpGet26NuMY5BzF2mUz5VUEq2bYORFiU0IbVz1ESjECoGP1AEOvLmpuiAbDJwSh4l
         H1F3BWcvPWn8HQhG6m+1Dr3EOzzslSO4kYK94bSE4bppCUITYkdqLGloZdE1sU+0B64O
         lTWfUmppUFSbcpGhE/BIAMD2l8OTded8BZG8B16FGBh1kdcBIMMJxlTIp1gV1uSHm5/4
         RGMMsHIR+uD4OAei3c64QL8K6c4VpntOmEhzB2f6DylLqKOaXn4dXYqMU5e9YMBaOQYx
         3UUrdnea36ait2gvqhkCpDXinsXEojyf34v/QBlUMEpjbiWnlPA7olPp5MIGLBsCbwPU
         YFtQ==
X-Gm-Message-State: APjAAAXX2Ph1NvM7Np0T9oTxMZdXOlWQvBi7xR8+6a/9VcA0nulDOVUA
        Upmk0HrDuYf2JZ3dt/CobId8jQ==
X-Google-Smtp-Source: APXvYqw19R+uAq8rWGJFrvZRkNKzLLbqBo0up+3BCPqhRIt/ceR4k2HbajPgDlT/k7e+4ftCKy6O+A==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr7650535pls.339.1571376248651;
        Thu, 17 Oct 2019 22:24:08 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm2178760pgc.61.2019.10.17.22.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:24:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: hci_qca: Regulator usage cleanup
Date:   Thu, 17 Oct 2019 22:24:00 -0700
Message-Id: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the regulator usage in hci_qca and in particular don't
regulator_set_voltage() for fixed voltages. It cleans up the driver, but more
important it makes bluetooth work on my Lenovo Yoga C630, where the regulator
for vddch0 is defined with a voltage range that doesn't overlap the values in
the driver.

Bjorn Andersson (4):
  Bluetooth: hci_qca: Update regulator_set_load() usage
  Bluetooth: hci_qca: Don't vote for specific voltage
  Bluetooth: hci_qca: Use regulator bulk enable/disable
  Bluetooth: hci_qca: Split qca_power_setup()

 drivers/bluetooth/hci_qca.c | 135 +++++++++++++++---------------------
 1 file changed, 55 insertions(+), 80 deletions(-)

-- 
2.23.0

