Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46017CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1632621D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LOsYNFJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503176AbfJYPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:53:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39288 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502304AbfJYPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:53:24 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so2969173ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BTCG2yDYkKpAkRxeGSjbivKMcUqz/dGEfEhScgVd6MY=;
        b=LOsYNFJ30GiYM0TVbIi0pCwCvywaMwemc8XsosqG8jQA2FDGLXmQCVlCHJvQN9NVCc
         38O7VnvVlV5Rhho6slDLFCKcj2PUM3nVSu38Z54JoM9bwlEehv8aG3l/YrI7ljI/H233
         t9LeZgYAKOqp9yl1JhH9vhR98y05l1Bgj/9RmdYUSy1K3Eizn0odTPD4HElXRDwW+zqa
         SbHUIwco2X/FvPXJPWNhZKS6+781cXqUP3IwB3C+X4AocW4H1Q3vF2qktYUZx+cdaexg
         a2C0S8r74ZMyiDS3299MKx7SHy122W9AkKY5QKp5mCrmhKUYYiZQGM6dcGcrnRQ4vjwV
         96Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BTCG2yDYkKpAkRxeGSjbivKMcUqz/dGEfEhScgVd6MY=;
        b=X6JvyU3LnzX9n6wabxCAdVAMQL7EXk77kR07GsXJYbOdrvP3ZQ0kxt+yf0w4XBpXfa
         gcmzub0UAzuLwTUve+36oIkk/floEKAj+Qw1HBUsMa/hk8OXP0wOZWjXCzAHwVtnNTqi
         dWyGaQZK9V/fUO6mgky7Ehw5xMoXgdzWwE6m9sN1z7EK9hJM7URKUc8JUEWfIDjH/LHA
         T5z41xiklP2REBANI4wMKt6Hj4MOtzal+t8RwmLUzGn7VVlGSOMikLOdOh/U7Ejlm7Vz
         6FHvk8R7zjdpXAOduLG3+sKd7d7BS2hG00zFQGvOPWsAge+QVJS/326B+RJDOhy/0viH
         WjaA==
X-Gm-Message-State: APjAAAVBjPQEijhe8ADzQX6TK1Zz4dNXZjcAzsp2NutbXK/7Z20uyviK
        1l3X46ORCf0TE/48QHUZJz1fYw==
X-Google-Smtp-Source: APXvYqyRv4NFbYB61iRVAes1oYhBMfB6E/EnuYSHHEoiWYs7t/2gjTWcjGIdGdbuzeRDIP+hxK08Dw==
X-Received: by 2002:a02:6508:: with SMTP id u8mr4734969jab.28.1572018802766;
        Fri, 25 Oct 2019 08:53:22 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t9sm308318ios.66.2019.10.25.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 08:53:22 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:53:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
In-Reply-To: <1571992163-6811-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910250852420.28076@viisi.sifive.com>
References: <1571992163-6811-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Yash Shah wrote:

> For legacy I/O BARs (non-MMIO BARs) to work correctly on RISC-V Linux,
> we need to establish a reserved memory region for them, so that drivers
> that wish to use the legacy I/O BARs can issue reads and writes against
> a memory region that is mapped to the host PCIe controller's I/O BAR
> mapping.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks.  And just to confirm: this is a fix, right?  Without this patch, 
legacy PCIe I/O resources won't be accessible on RISC-V?


- Paul
