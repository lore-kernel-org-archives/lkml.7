Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0898FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2434218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8ZLEXNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:21:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37777 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbfLSNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576761670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=M8ZLEXNh6zU+k+ikTgrVxJSdXd42PZcPDOw0npbcP9BJnn51YSeUxHqNQA3zQ5H+x29gPg
        T4qewjDA/Cs0YZZMSyqO57JJ9yC6hrMM3XPCA4QtRlRxiWJzf0hauTiaXGuN45D10SsN3z
        J14a/gQ94XA56ua32+OAWuWQyWqAV78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-i39QrJVSM0WZBiS5wMbNLA-1; Thu, 19 Dec 2019 08:21:08 -0500
X-MC-Unique: i39QrJVSM0WZBiS5wMbNLA-1
Received: by mail-wr1-f69.google.com with SMTP id j13so2344239wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=L3ipoASX9eiFnzLBrLF3MIl64uuC1FNL3roWcNPyDppHWw1g+XMmjlENfCxlbEnfBk
         R1A17oS6IDqH1OcQ1/aferB5kdb2lWwXbpotJX/yCt2sDdIApCGOzjlxJ+RYGcojHw7R
         8mwOQKzJWpVkv/vWOe17unY3PdHs/0p2rfTm18NS0aneiwPByuzVGubxJZBfWAEOu+eq
         t5vO3r5wecVEb3R6umhSeIC6GN7hYhrr2CQZQEINnY/XuxxEnoeT3zLtgxEZ4Zpnwz/n
         woWPi56w5D04D7T0Z/nIZcW7EY6ZQajfTAkqz62TvfC+dJ1oCWNeMTjfygkhSPnHvsQW
         BPdQ==
X-Gm-Message-State: APjAAAUYoOX3T3WaZVzBP9hH2IZemJ1wsX2HDwT6ZN8vFqFwVYNpJ5Ty
        PpFwp7AIv+ZKrf5aJWN/9f6mRlcY3b2a4wvFJfpYHcYM3qgwS9lVnhdnKFSJ7xf+o5zX+RQ51JR
        qcM+ao6h9/tRdmPUKdbf1sA2O
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922284wrv.269.1576761667269;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYsmkicq1CgpePFwwJNc2lMQupRm5P+aon/r1P4LvdWHpza4ghagzA9OygT/h18nUeOHn+jg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922266wrv.269.1576761667016;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id 188sm6488919wmd.1.2019.12.19.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 05:21:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20191219132103.GD13724@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019

Argh! s/2019/2020/g of course. :-/

