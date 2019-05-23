Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BED820644
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgMBxKYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfEWR5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:57:41 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39971 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfEWR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:57:41 -0400
Received: by mail-wr1-f44.google.com with SMTP id f10so7259514wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=npurEhQFkRrHzUL5AZ34/mton9sqbecFYDOR6wrDNXw=;
        b=YgMBxKYLwA3BTuAwfHJvTccICQQi7eLvD+O2qkQAdY3215i9UdMt0BKfbs10bS1aJn
         zRDm0yDNwiTPH3LFLziuiUmp39Q2kImc7WH2Rhx6/VD3ThUN5H5Y0FsnMT3hrSdB04tW
         VYAs8UdoA/dtwSJ4+9oBuuCX85ijbib4/Dxy0FL70nEqGlG1RcVJ9moThn8ZDZa6ONvi
         m6bSW/o63f9iCyxorHAk5Q7u3pUbxwIMyrK+piHoDBynsp8L6zA5zlCCl+0cHbIj81Qj
         +nohXCZkkrl5+hUPYp7h45T3GPwzCTNA4XQeLgQnv2q/hzbKMomMiduHr03Anj6JJF2p
         7APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=npurEhQFkRrHzUL5AZ34/mton9sqbecFYDOR6wrDNXw=;
        b=Lu+A0NBN5I4XxYv3Q9kYgXXAlv67SVN8Cd8t4elpV6/JuclUZfWOhBM/29lrmkd4K9
         fCI5kJHukMuOMuFQJix+Us5GzNrhc9eSJrhmCougYHR1pWb+G3O5Mnd5gjCEhZVNTqDz
         dF19TGDAPAc6OULhqh09XrsoyuJP4RF/MlkuV2gRRVZZIXhsM5Kb4xf3Pq/4FHpUC1sk
         71M1A/8UHt34nMFEi8fUhgk9Q8tWg1Ohj02cUp4SGzQHJrRw8ojyweaWqA26MV3xY4ij
         MlNFk6w8+RJtjc/PGCux8F/X8JTFnOhrQHRLz055lYbZoXg8eIo9Gpl6NG7+1AAnCWTD
         wARQ==
X-Gm-Message-State: APjAAAVku4Eci1bxmNSKlhHh93IojT/PLKAzSYbUkOCUn1HMDzm89coJ
        24Kud8sllYIZeX+Vrj6ADF+5QDg=
X-Google-Smtp-Source: APXvYqzSqkFIzvlcu8Dfoa2PcTkILCHL53QGzH957rp6Wl3AVKO80ws7Z+PKRSpk1jU5iYbOLC7xdg==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr55312765wrl.140.1558634259680;
        Thu, 23 May 2019 10:57:39 -0700 (PDT)
Received: from avx2 ([46.53.252.55])
        by smtp.gmail.com with ESMTPSA id b5sm26243888wrp.92.2019.05.23.10.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:57:38 -0700 (PDT)
Date:   Thu, 23 May 2019 20:57:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: fix "start_code" evaluation
Message-ID: <20190523175736.GA6222@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only executable ELF program headers should change ->start_code.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1026,7 +1026,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 		k = elf_ppnt->p_vaddr;
-		if (k < start_code)
+		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
 			start_code = k;
 		if (start_data < k)
 			start_data = k;
