Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305A22184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TagtwPQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfC3E4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 00:56:23 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33027 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfC3E4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 00:56:23 -0400
Received: by mail-oi1-f173.google.com with SMTP id e5so3355674oii.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 21:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NDH5M1HR79nQl3W+HKG6wYCnLsxMYX+/zRRqVQVrfXM=;
        b=TagtwPQoi/RLYk8fBn+aZ28+G0aTOXRCfZ+npCUCtv1uBQDUgEz4vcdwriM9e/DcZF
         qM/UkyPBfRcw46J+TKwA6kvz9702adQPEAFVOjLpIZIbDk0d+8nmfgkf8ije1SaDoGUe
         HH0nUVwSluRjWTJ16t3fysyHGa55qzm1jNRw1A37nBujBgopKXUlbgHQ4kTvu0GsZuoF
         GArfAqKTl8998/80DL9dHTIvo925c2YkS3EB/KdgxMMkIYp+dcvaPst1JfQA8xmE03Zw
         WK8IfCRtWJjO0R1pL93ombdF8/tMnACJYK4H0orPIWfwuCufRNtH0Tv49MjYIfwGboRZ
         yEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=NDH5M1HR79nQl3W+HKG6wYCnLsxMYX+/zRRqVQVrfXM=;
        b=Z0x5B+h+48RXW9Rdr5SyA/OTYScnckEOgGfvEK8OWx8YruhStJnduZWD+zZt1qtubH
         C6rnmnpIWr0i+I6F8NBOamEh1uFYYKG05jWm1ZGKMN5pMG2L6t/4j0km9OKolsPKEyJ7
         Ev3FXY4cpu//Acmb00f8o+T1stkQbHOKCoB+UUdVi3fE14I2Eer6VvyEcDqXUp7GwEuS
         gnHogzod32fem0PqQI7hYLXOkPD2NoKU5DlUDTJ+YAhexW9G+9PsoEMjN2AbmF7Bn/FY
         JKSoNJwma5nTeX994SstUre2kW+SP9tT4vMlWT8xP/4zQnUFSQQAwT6/mCffeH/qFqmI
         Havw==
X-Gm-Message-State: APjAAAU6PpdUKKfGS1LTUepILl+LPvDQLOrH0O8vWRmS1H/JrWFUsSnc
        zMvuXyGG/Mi9wej7tdNmgkFltA4v
X-Google-Smtp-Source: APXvYqzrAbN1b4coZW5zUFy2WL7P0kZKViz8wKAs1Uyun3Mx87Yage6ArwyCqd8VSh8YSIbClwwaPA==
X-Received: by 2002:aca:3dc4:: with SMTP id k187mr6059344oia.40.1553921782307;
        Fri, 29 Mar 2019 21:56:22 -0700 (PDT)
Received: from [192.168.0.2] ([98.156.228.54])
        by smtp.gmail.com with ESMTPSA id d70sm2007910oih.18.2019.03.29.21.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 21:56:21 -0700 (PDT)
In-Reply-To: <241612a5-b041-e419-a3bc-e2a2e6ef1687@amd.com>
To:     ghook@amd.com, joro@8bytes.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Message-ID: <01b394b8-a402-a3d5-7cc6-4787028ec155@gmail.com>
Date:   Fri, 29 Mar 2019 23:56:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190329-4, 03/29/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on a Dell PowerEdge R7425 system on which this problem is easily reproducible.

Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>
