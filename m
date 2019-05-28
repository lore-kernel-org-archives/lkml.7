Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6CC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AFF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dof0bP7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE1Ad0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:33:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46070 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfE1Ad0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:33:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id w34so5170135pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IBU2i2x60PXCQpHcmTZUjF60sIqtVaUQ2A7Q1HpQhSY=;
        b=Dof0bP7+5ryIVKEYrxrpraI1+1JHvC7NpZ2CoFuXZHktp4iSeTCvZ6w7KZc/COsC0M
         fxPhzW5Zhui/TA0PBDV1y3n5QBPpkH6yUlkEj6gcTd4oBHO06jZO0eSsQp2wy1b4eyRo
         x0mmbzo9OxGInvNWQa3RTl8zc/jjsSGhQipHO1kmMNUjen46Jt1ee8Ch16XjgEtJ+gVd
         QCfqmtTispz3Lm+88GOlNtrXdIOe9iiaDG7f+J74bzDgHK3cOA8AqZAHPNudEq9ZP4p9
         apXuH1mPp03YNqLERKs+t3O2k9acFJmVSnf5bF1v1UfRhXKh4CCKlwSpWzVhwD2dIM6u
         XjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IBU2i2x60PXCQpHcmTZUjF60sIqtVaUQ2A7Q1HpQhSY=;
        b=p6zA1essdoQCs8xS0hwpu1kdlYUWZ/qTe+zcHqo3BSH3Li5IRIDJah1OejtNMzxuM5
         N7a15IiyycSHEboliK29kd9jNgYmlGg8EZmMRwOyidmbmNhHm4umbN9EUcLIwvMQCody
         JGHCCYvnYVBDLMdK01o/156c9t6/50xE4niVS6aQ9KEhkMA3jwqfLy5c2TyPRVz9POqH
         qOKqlwnMaKujHOChI86aNFBaodd8G94ATrccShlxuML1xFclgbj0a29yftoARB3PXjbw
         cscGl/leYRK8gnMhZk2bRfd1+Do9Q7kTj+BCF4qZkm6XYr6qF3SVyAEY2LZKCXRxzNJw
         Rilg==
X-Gm-Message-State: APjAAAUpsRbiSleDKw5URvDhQIbAdCfywIOD/wNA5u+TyHhVdypmzoRq
        TuEdDAG2C+xig1+L7LPibdo=
X-Google-Smtp-Source: APXvYqzeS6rhxk73WMsQD+WSuqxkjPYUuS6v9JTEyDH8D7oyMoH+cD78TWj8NW9Nm+gNRJ9nz1rKAw==
X-Received: by 2002:a17:90a:e38b:: with SMTP id b11mr1796894pjz.117.1559003605642;
        Mon, 27 May 2019 17:33:25 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id v6sm6997029pfi.112.2019.05.27.17.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 17:33:25 -0700 (PDT)
Date:   Tue, 28 May 2019 08:32:57 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [Question: devm_kfree] When should devm_kfree() be used?
Message-ID: <20190528003257.GA12065@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kmalloc() is used to allocate memory for a driver dev. Comments
above the definition and doc 
(https://www.kernel.org/doc/Documentation/driver-model/devres.txt) all
imply that allocated the memory is automatically freed on driver attach,
no matter allocation fail or not. However, I examined the code, and
there are many sites that devm_kfree() is used to free devm_kmalloc().
e.g. hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c.
So I am totally confused about this issue. Can anybody give me some
guidance? When should we use devm_kfree()?

Thanks
