Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B1206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfyHgDNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDBV4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:56:04 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:34876 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDBV4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:56:04 -0400
Received: by mail-io1-f73.google.com with SMTP id k2so12091430ioj.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xvP3HVYqu27tBHwzKFNTdA4Dj9iMF57SLtNgy2OpezQ=;
        b=VfyHgDNKV9JbLqB69j2NzoAsjNzEsJH4msewUCfmmcf4B+YD4VmXDFZGXL+nA14U6+
         0WFMIxqPp4NTXWofZgYEDVxOi/PWBvf5cWFrGO8FsKwd5UxUiuTCrZ4MRwKzVVq2kn4x
         O2MF4p8GI1G8abVOzJ6UkEIo9VztcYXLQvRHP+HoNZlgLnwgiWhDzcdZmxEZMtVndOo7
         xsk0pBhHCdjbW1rZLp3no+oQjz46+THK4c0izoez+jJjK2t6XDFYACjxBARdy5zRoVxi
         AyMV5odZ7nw5ZVj/+KosDSeNln9E0PHRy/JNEHoH2EvYG7bk5uN5LM0SoFVJBzNRlKM5
         ntaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xvP3HVYqu27tBHwzKFNTdA4Dj9iMF57SLtNgy2OpezQ=;
        b=q6A8qko2CcPujiMRjcdfAx3UEDt4zbLW5eLrahV9c4xBy8ndqd/pxeKQb+s6BgOOxl
         jsySDSfU/PQFvMP1KesnWSUzDIEh2B/ZnrdNMQMPQTScgutl3NlAMQ80yPLSgyB8bcpu
         1KyLXfxogjvsZJ0xk+QgEc8f81lh/vrcyQEKZB0GpT0w65X8lKc/3pyLppvOdj9sL+k6
         4YEa5B7k+da4ptFw/0YH8FfhtTs345l4W51IIV0RXAX4ulrm7i5zrEYdnPpE8kJZSE9n
         D8++2y8xmUWWK3ueG3ylcHm24xRuHLRFNHTLXlKi5nqsbxLkktdJiXmTiIBsWAZyrT+d
         9+uA==
X-Gm-Message-State: APjAAAVDd/iFR5ByHuwTqE7Yt51YUxsJa/xABeMcJ0kaW1/6by+fNzt6
        iAtQG8cOWJviqRLrnUn7BYg+msH6BkJhUMq4zFNyfg==
X-Google-Smtp-Source: APXvYqzjhOp3ULfixrdD4c3fYX7kTypxeaYqUi5Ty1y9PfrtKr7FLJZK5FeeAkcbWI2jZzKWpJT7Lss5z/8pdIjDPJPB3g==
X-Received: by 2002:a24:de45:: with SMTP id d66mr8575717itg.7.1554242163229;
 Tue, 02 Apr 2019 14:56:03 -0700 (PDT)
Date:   Tue,  2 Apr 2019 14:55:54 -0700
Message-Id: <20190402215556.257406-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] TCG2 log support build fixes for non-x86_64
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to fix ktest reported issues with the crypto-agile log
format support.


