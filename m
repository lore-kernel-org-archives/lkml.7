Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA220C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcQzvsRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfDXVNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:13:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46087 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfDXVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:13:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so15781004lfj.13;
        Wed, 24 Apr 2019 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6APf5odZec6P6x0YRNRDRCj5a3L6TwNF2nxCHmgiq/k=;
        b=hcQzvsRppWmHiS8+WhO1Y0up2V2m2c++KPts/bK0SV7Sjgdg8xir8sLd9IsjsxEWwk
         sM3IQKJ5uFp4tojS8sVn+TBZk4Hru0pkPaIoCt5XruqamNSFdv5Lp5cJlZThG9uD9x9A
         9s6tNas0VOkmNGdPTmmb6LuD0DvF6Vc1atS4rt3xTRFq7fNTDLqx/K+uV3ac+oWHRpyf
         YkMpq+eTuGiQaWy6xfKozas71vbbNbIgOmt1pAa7HsweHQl7EdARvtHlxlsBrCdI62Qe
         O7E7qBXwlWUDjZ6CS1aDMCr3aoRha8qvBQX+a+nWQGuBv5R7aE9R6OQpXXeBz7Q9cXr6
         7v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6APf5odZec6P6x0YRNRDRCj5a3L6TwNF2nxCHmgiq/k=;
        b=k/9xL4a20W7vH/GVXu4ZzSVNtVNcRGvhQU/6T/qAaf1BSOZbHOLw5P+TRE07Ez2USx
         Tw/04Vm7eTS51mX1y1VYrV0EWsOOLdarNECw9qGfx4NH42ktUW8n5tcCttsAXDpEuXbp
         kOxADlNrNNLBwcWfL6iS7ysEhUr3p3eFzZsqTl0vsic0f55NYM1wnWaKipmhDOE35t6P
         yseNZpOkmihcIu3jmfqeDykxXZMAtUJxh+f5e9DX6NNb3aKUjIyS/EPQhcSHzkuPqfXI
         nBQKN6rsHbWEB2KckastfRNWWrLW4bH17qlPYCFdlxS1Ti9Bt5BBUayjp/sC3JnrpP92
         9tYA==
X-Gm-Message-State: APjAAAUuhfUwacMaUwUtN8FAt3J1k9IMYoxj5d5r0Lcxi7w4y5pPAhPQ
        SbSXoMQxAg4diuD4e4f/nNQ=
X-Google-Smtp-Source: APXvYqyY/N3cRAN+WSNd5fobvNeWFfl8s4LWCMdmZEKuKfoMl9WpSKbKxiSR9geChh3hdMZrk0IkmQ==
X-Received: by 2002:a19:f703:: with SMTP id z3mr18750645lfe.119.1556140413161;
        Wed, 24 Apr 2019 14:13:33 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m3sm4540248lfh.94.2019.04.24.14.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:13:32 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] usb: usb251xb: Add upstream port lanes polarity inversion
Date:   Thu, 25 Apr 2019 00:12:04 +0300
Message-Id: <20190424211208.17499-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago I created an original patchset with functionality of any ports
inversion setting implemented. But while I was busy with another work,
Marco' version of the similar code has already been upstreamed.
So I decided to at least refactor my patchset extracting alterations,
which I think might be useful in the driver.

Even though the Marco' implementation was correct in general, it lacked a
small specific detail. The polarity inversion property might be setup for
downstream and upstream ports. Both of these cases are covered by current
'swap-dx-lanes' property implementation, but there is no any mentioning
about number 0 being considered as Upstream port of the hub. This might be
confusing seeing the rest of the port-related properties accept
only the ports starting from 1 (which is starting number of downstream
ports) and don't support number 0. So in order to unify the 'swap-dx-lanes'
property with the rest port-related ones, I'd suggest to make it being
responsible for downstream ports only, while upstream port lanes inversion
would be enabled by setting a new 'swap-us-lanes' boolean property. Current
property names mnemonic also fits quiet well for this update.

In addition the usb251xb_get_ofdata() method is getting to be too
complicated with obvious identical peaces of code. In particular it
concerns the ports-related properties like 'non-removable-ports',
'sp-disabled-ports' and 'bp-disabled-ports'. We can simplify the code
responsible for the properties handling by moving a common part into
a dedicated method. Needless to say that in case if the suggestion made
above regarding the 'swap-dx-lanes' property alteration is accepted,
the same could be done for parsing it' code as well.

So all of these updates are implemented in the patches of this small
series.


Serge Semin (3):
  usb: usb251xb: Add US lanes inversion dts-bindings
  usb: usb251xb: Create a ports field collector method
  usb: usb251xb: Add US port lanes inversion property

 .../devicetree/bindings/usb/usb251xb.txt      |  6 +-
 drivers/usb/misc/usb251xb.c                   | 73 +++++++------------
 2 files changed, 32 insertions(+), 47 deletions(-)

-- 
2.21.0

