Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21760CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D1621872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W06oXB6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJYWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:50:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39904 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJYWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:50:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so2057418plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WK3SlUf5Gs26MRGfMYO+sZq/r8if+NvP4msj/EMhnDI=;
        b=W06oXB6IMpWhM8dtYxX4fJ2EYFzVUD5CG6VL1kdGUPIGPjDdJOvFUBgYM3ETY3MfKK
         IGw50t96VojqD+FT/EO1EVcSuM2ummWiEQqaHrpkfnQKdLdjWpXhJPCoDfuncYeLu7yR
         S/dND9LH65leNIe3NixQsxPxXFhbVLUDu7zLJ2/R8HjgnPgQhadWewKuo7gGRIcEY+jq
         qd+N/q5dVs390J3XqSeJcYZue+xNm061VT5uIFLhDjYYJPS/W6XuVG89a3yHNM8afRuw
         gVMVCjzQ/OJ6MmZmisewh8Ds3g1fUbpntD6qrNjczAA+0j4/t78L45JkiT3Nk0mLNoe+
         qcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WK3SlUf5Gs26MRGfMYO+sZq/r8if+NvP4msj/EMhnDI=;
        b=qzHaUtkYHoXFNof4bFXlJXnwDg1Y+esSv3qgoK5DYy9UwWiZ3mfoX8QluJz8bt4j7I
         79Bu78Rh+P9fAceIKhISNbh43wZZw4bFf/APaGKGMY4bM2jGFPHXebamhyQMaIdb1YF2
         NLO5BZbGSYMGmV2TBykIb77WgqqajUAZDTsJjsDGR7XDrfWc+yLu7IN9MW9xPip7anvs
         zjgKnYSLiI6OQSgk63vYvGIscIOdZupnuVIEhLFvQXFPEIUYbzTAU8SbfMW0p3oKDfkW
         67nJJQ+IoNorSj8Zw6/X3Dkd43Wr+Qt3KyK2BEziQUN0hJ+CiON8kxMtlsa0uo7sScX+
         lcFA==
X-Gm-Message-State: APjAAAXRNgA03UdI/ktRYV2725MraAXgs9XTmg+Nfn5c/3rIp5h2rEQ9
        RH5/XoQk01BQ1LLCbFsCsJ6JB6EBCp8=
X-Google-Smtp-Source: APXvYqwQLQqa6cIVroIB0jGdxbexLrpc2SfRdat8vKLK45RzjXk9xs4WDP+k4gpJHIg7f7PX43Yojw==
X-Received: by 2002:a17:902:d913:: with SMTP id c19mr6398645plz.48.1572043816005;
        Fri, 25 Oct 2019 15:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o15sm2758018pjs.14.2019.10.25.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:50:15 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 0/3] Support non-default CMA regions to the dmabuf heaps interface
Date:   Fri, 25 Oct 2019 22:50:06 +0000
Message-Id: <20191025225009.50305-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the dmabuf heaps core code has been queued, I wanted to
submit for initial review some of the changes I have pending.

In previous versions, the dmabuf CMA heap added all CMA areas to
the dmabuf heaps interface. However, Andrew noted this may not
be desirable, so I've come up with a DT binding and code to
allow specified CMA regions to be added to the dmabuf heaps
interface.

This allows additional CMA regions for things like cameras, etc
to be allocated from separately from the default region.

Review and feedback would be greatly appreciated!

thanks
-john

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

John Stultz (3):
  dt-bindings: dma-buf: heaps: Describe CMA regions to be added to
    dmabuf heaps interface.
  dma-buf: heaps: Allow adding specified non-default CMA heaps
  example: dts: hi3660-hikey960: Add dts entries to test cma heap
    binding

 .../bindings/dma/dmabuf-heap-cma.txt          | 31 +++++++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 13 ++++++-
 drivers/dma-buf/heaps/cma_heap.c              | 38 +++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt

-- 
2.17.1

