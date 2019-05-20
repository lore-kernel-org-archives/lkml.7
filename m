Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22174C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7B216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5wW8lMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfETNyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:54:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44790 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbfETNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:54:01 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so11032857iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNcQkl0sbDGXxnYuX4gXEpMWKK3coY11enMS7zPLh3A=;
        b=R5wW8lMc1iy8WX5sYIP1b1h0H4/nA/j52JRPwd4H4/d96WL7tLLiJArjqoRqRX9OPB
         FSg6TjfoAJXORsyizA3JhqGza/b2CTsNAAcuwuVQFl4C4mhXyIEo3mVGb8ZkEIVUNVDh
         L40iihL4Q3zEayB7IeYK6/ANJogh5XRzFdpYCWnBjn30ZDh/PMc1opt203xC/d2kr+Xg
         +hJKwYigYLilykiT/0P2KR03lJ0mR2+W3r/w/VuUYu39KYpJ5BvxsicRHefYns1DleK/
         FDLseKCMrYlnYZTVbqG+qY/WnjOAa1e9JgUfjK8safuRTCLVD0JF1XGvZsQ/xfYomin2
         yiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNcQkl0sbDGXxnYuX4gXEpMWKK3coY11enMS7zPLh3A=;
        b=j3RF/kVLmXX79WAd940iMPnFsqy0nfcolOwKYAszt0vL968JFRD2w8qpAESAAyx9/S
         IWDFU3PBtFIL5IMVpdiPYTIwTu270L8GVdZwqhW8N1kCK07szB6s08aUgnXMBrHOuYQw
         HLnoCV88GsLJaQwCug5PyiUc6NQQCSOZAykkK7jYIuj/I1odWBzYuWuFxdVsMQl7ENvr
         NFNr4SSC1s286QaebhjGBxOGQhzNPlRe6Gs9nQ8uiBQPNe4iafDSMcFppUX3o5BYosWu
         PRTayIwznOup7vVld8EtNt7Z10WA0JdAw6zFNreFoeDFTS2Rx12Yt7bkDKaCQuwMjWAV
         CN9A==
X-Gm-Message-State: APjAAAW0fnaYFN1pb7HVjhUCcw1Jjr4bfyu8w7SViviGej2O0+KOOb1E
        2vRdELLUjrXVT4/qsKrB5sBfbQ==
X-Google-Smtp-Source: APXvYqynHsjMtF9qAVZpY1JsVPL2bqipIldd2eim0mxY31JSO0vulzprtm9VZoDN7/PUuSG67E/g/g==
X-Received: by 2002:a5d:9d07:: with SMTP id j7mr24786480ioj.39.1558360440641;
        Mon, 20 May 2019 06:54:00 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id n17sm6581185ioa.0.2019.05.20.06.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:53:59 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net
Cc:     bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] net: introduce "include/linux/if_rmnet.h"
Date:   Mon, 20 May 2019 08:53:46 -0500
Message-Id: <20190520135354.18628-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main objective of this series was originally to define a single
public header file containing a few structure definitions that are
currently defined privately for the Qualcomm "rmnet" driver.  In
review, Arnd Bergmann said that before making them public, the
structures should avoid using C bit-fields in their definitions.

To facilitate implementing that suggestion I rearranged some other
code, including eliminating some accessor macros that I believe
reduce rather than improve the clarity of the code that uses them.

I also discovered a bug (concievably due to non-portable behavior)
in the way one of the structures is defined, so I fixed that.  And
finally I ensured all of the fields in these structures were defined
with proper annotation of their big endianness.

A form of the code in this series was present in this patch:
  https://lore.kernel.org/lkml/20190512012508.10608-3-elder@linaro.org/
This series is available here, based on kernel v5.2-rc1:
  remote: https://git.linaro.org/people/elder/linux.git
  branch: ipa-rmnet-v1_kernel-5.2-rc1
    acbcb18302a net: introduce "include/linux/if_rmnet.h"

					-Alex

Alex Elder (8):
  net: qualcomm: rmnet: fix struct rmnet_map_header
  net: qualcomm: rmnet: kill RMNET_MAP_GET_*() accessor macros
  net: qualcomm: rmnet: use field masks instead of C bit-fields
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum header
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
  net: qualcomm: rmnet: get rid of a variable in
    rmnet_map_ipv4_ul_csum_header()
  net: qualcomm: rmnet: mark endianness of struct
    rmnet_map_dl_csum_trailer fields
  net: introduce "include/linux/if_rmnet.h"

 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 11 ++--
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   | 36 ----------
 .../qualcomm/rmnet/rmnet_map_command.c        | 12 +++-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 65 +++++++++----------
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  1 +
 include/linux/if_rmnet.h                      | 45 +++++++++++++
 6 files changed, 91 insertions(+), 79 deletions(-)
 create mode 100644 include/linux/if_rmnet.h

-- 
2.20.1

