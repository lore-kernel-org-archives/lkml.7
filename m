Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AEDC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75B220C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrKIZgqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfEBQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:54:10 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:34090 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:54:08 -0400
Received: by mail-pg1-f181.google.com with SMTP id c13so1339173pgt.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+hdxvpCXVtGpDJISGPH1holqF4XwrImqrdJb9+2HhCY=;
        b=CrKIZgqRmvuhmRQD/2JgtANStHORnzNgR8StTXldSzdnm/04SIPqkjNG2tnKfTF0F7
         AVxcUgmHLbzdHmW9XnG9sOYoseJrFAvQo7pkgd97/gdSi2f1qk+1ySbJlry6yiTnplIy
         trrXqStm4zO/0L14QA6HSWpsdPJc8jItPcUjrqPIJ8tD13Kc5UTOLR/r0pfIG5H2oRZ7
         AtBki9c/WAP/bkvyo9BKRRKo4WY1vnxBYSOczYBB5d+NESCrDkjhdX7LefeLujHZheoj
         EI8hmelbswwCPlmubCIZ3t3CoiuykKe7axxzlm/xDYl6D9GDG55PZPOSgaJ0Es1o+3l2
         RjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+hdxvpCXVtGpDJISGPH1holqF4XwrImqrdJb9+2HhCY=;
        b=ZaOvL2AaNo1wPZkHnrJGJuDO9MaxQhjgRt1/782T/eCD2OcT9LDkUatrYyriaXcEu9
         giXhKYUiaPLdsmTNQFch9/xorYCeB1GZVSXp5IWQg2Vlqm5SplyIsPoj6cQkQJ3EjkxC
         7AIEROBpiMwdHlaTwSVse4f5gdEq/q/s96Yc9zKoLQNVpG21wSVfemC0a+67dvcRfvkB
         8/MWxCi9y0wVgUMTdy25+jPgG2ZRDV4PTjwMDHaaSpi3ZKi5b9Ve0fnQaNR/9Qp1G5gS
         uXxzmmb7742Xmu7FNvl7CrP1wkNDCbTvc+RHq7HUxyr9QZuPBiwqjGkd131NkmfaiCzT
         hckQ==
X-Gm-Message-State: APjAAAWBa4fHUekc8O8wbNIg7SkLPjL/pJTzwjycco/hYlGWJRYMZJ0G
        wOkv/p2kMQBVAoVT1y9YCLZ+Y2MLe68=
X-Google-Smtp-Source: APXvYqyMk7BxKC6gCE857QESGNKupmNDXSr9J09HFerrUAsQIUDKdq8qP4O/VYibZ2Yp3oKUrRjlaQ==
X-Received: by 2002:a63:af0a:: with SMTP id w10mr5016100pge.67.1556816047282;
        Thu, 02 May 2019 09:54:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j2sm69949pff.77.2019.05.02.09.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:54:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] coresight: next v5.1-rc7 
Date:   Thu,  2 May 2019 10:54:01 -0600
Message-Id: <20190502165405.31573-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please see if you can add these to your tree for the coming merge window.
They are confined to the CoreSight subsystem and have been in linux-next for
a week now.

We can simply wait for the next cycle if you think it is too late for this one.

Thanks,
Mathieu

Leo Yan (4):
  dt-bindings: arm: coresight: Add new compatible for static replicator
  coresight: replicator: Add new device id for static replicator
  dt-bindings: arm: coresight: Unify funnel DT binding
  coresight: funnel: Support static funnel

 .../devicetree/bindings/arm/coresight.txt     |  60 +++++++--
 .../hwtracing/coresight/coresight-funnel.c    | 116 ++++++++++++++----
 .../coresight/coresight-replicator.c          |   6 +-
 3 files changed, 147 insertions(+), 35 deletions(-)

-- 
2.17.1

