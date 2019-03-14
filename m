Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0575C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C6921871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P8+mCjAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCNVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:48:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34643 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfCNVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:48:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id n6so4329777qkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOKQl77tlcKdRXwv3KLrLHAh/2xmuI5xRqwzoMDlSx4=;
        b=P8+mCjAr7lnNQFdtsmGnIznAasCG0PZk/LqTaPIFq+05uZ+6It+Fc6FDUHyFSZS1Re
         K0yhwj5maXrCUXYZztGC3lNcRo5TcU6qhPv/FrMsCnLGbuVVKNYuE28NJBvL1R+pyu4X
         uTvHXqrdoFttcV5sLbO77rUiuU2MMH6lT5U1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOKQl77tlcKdRXwv3KLrLHAh/2xmuI5xRqwzoMDlSx4=;
        b=qemZ+ewqbz1XBF5f1OjS7s+FTZo1YQ2n3Gm2BJqNn70ialJWhPX7/s0PgyNNaWW/Mn
         2UXuYS/3zaH1EOjwXdjCKPX0B7Qrvz70iirQdEL/YaF4HP7d7OiApLi7Crlf92+qJXrJ
         pP+FabFavzsMMbwerUzhg2m2tdQk9C2BmqxnTRo2otrXGoKobZjWgi6BgDWt/L7M/pnz
         X8UWyiaOzLt0UiTAO3VKRO7FRVvVzIn/hcmKcbaW+hwlJ18UepYs6nnpw5rZoJj/LoOK
         YnGkxHHQkEX4Ty6sa7mvYf465RFt/DQF6L7TujuzMhSkAV2gKsC9ExOQGpg4+ZljrSJk
         ij6g==
X-Gm-Message-State: APjAAAXhdExWG8XMflPjUddMQ3UV9z5YGOM+harLeLA1nOpWD9oESNyY
        NmEvt8u+5G7bBJaK4eAzyI6nQwC72LE=
X-Google-Smtp-Source: APXvYqwCxiff+zhOEF5mlXUotlJ7UvJaZgJwyYErpWAp0blmeFVnsQrKonmidZ3DVpwI0ETdoCK0lw==
X-Received: by 2002:a37:83c6:: with SMTP id f189mr397438qkd.196.1552600136409;
        Thu, 14 Mar 2019 14:48:56 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id o19sm96827qkl.65.2019.03.14.14.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:48:55 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 0/2] 
Date:   Thu, 14 Mar 2019 17:48:42 -0400
Message-Id: <20190314214844.207430-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documentation is for F_SEAL_FUTURE_WRITE patches that are in linux-next.

Joel Fernandes (Google) (2):
fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal

man2/fcntl.2        | 15 +++++++++++++++
man2/memfd_create.2 | 15 ++++++++++++++-
2 files changed, 29 insertions(+), 1 deletion(-)

--
2.21.0.360.g471c308f928-goog

