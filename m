Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE02ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE1721925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503304AbfJQSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:22:33 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40616 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503284AbfJQSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:22:31 -0400
Received: by mail-pg1-f176.google.com with SMTP id e13so1815424pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=qJ6/zX4CJXyT8jN+BKjWcB5Fc+YC0TUGB76PLX5dDk8=;
        b=IamCJkFhkOXIgyr4JwFYbNzQ/1bnYUb4+2zCKU4uDc57G5D451moKId5xE/I7KFBF+
         y33EFihafHCfVn8SzWlMbKWveB6w3yi7a+294K8BmcYWGOAcAZ3+19mwfOkmN0WA/oo8
         t3n0mLyw+WwzENnZfH4W+9vHhR4k2zfXHDKG4mEK+ZLwNzPLGQK2lQNkJXeCLjwZ+z8f
         1CwXkoPBbLfwK09riRQHbgAJt0CPqZryAez2CxO3874GywPpBSjx+ednljO8+n7hAQqk
         oYZ1YwDYvkyicMwFMEOOIoEkOxg6sNFWrYcfZeIwM1y/Lodte9Ql/L+SON861lx67F91
         LPqQ==
X-Gm-Message-State: APjAAAXVeS4WlrQs+5H0HpcUqeeKCPBMWPApd3av1ywbHuDsdvBybdFc
        1IwRMRsE9gvgQ5U5ZHLNq1qX/A==
X-Google-Smtp-Source: APXvYqyJNHvaSBqrZiRuB0+cioJyGR8wen484kCJG+fmxEESVRjqBPiqSzXAunoRqzPXJMJEDNhhdA==
X-Received: by 2002:a62:b504:: with SMTP id y4mr1684760pfe.198.1571336549961;
        Thu, 17 Oct 2019 11:22:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p190sm3078797pfb.160.2019.10.17.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:29 -0700 (PDT)
Subject: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
Date:   Thu, 17 Oct 2019 11:19:34 -0700
Message-Id: <20191017181937.7004-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This came up in the context of the microblaze port, where a patch was
recently posted to extend the whitelist.


