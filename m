Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8624206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ShoeAEmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDIPdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:33:20 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44183 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:33:20 -0400
Received: by mail-qt1-f170.google.com with SMTP id w5so20233970qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+kIUgCSURxLIijTOZc5ORkPl4wS+TgwMM8hMUvYnAg=;
        b=ShoeAEmihccne9EIc109URMOTio+ulyVPf5gBLBPI0+RqBJKL9hi6BvaFYfaFXY1EV
         fFa4Qpj27lfgv/X0uPR2rfjAiVl4ABuWOQpWa7R7Mtq6vqGnPKGwfNm/smpXKCpoS4dj
         y4OhwU017u8yqBYN2g6VK8LnWRjW4OC05fWsG4scuE1MD0+BEjuXQLMZUXttMo0qaC99
         UwWn7RTaGmN8hmZ3fyW/zK5zuuMorDk8Lm5tDq6mK4Y21g0XTLUE4fMz47ARJJ2AX1RZ
         5WDMZ+BJ9qSNHxbSPUJUwjcJKRH4PVQLAp+wvJbOpi1VZnIiipsFfx9Crn7wN/I7gyQ7
         6jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+kIUgCSURxLIijTOZc5ORkPl4wS+TgwMM8hMUvYnAg=;
        b=bnOwHZ//qo2Km2E0B2HLpFEP0pHV1NSC12iKgQ6zP/xydvTvICBzP1aTfaAns2b2p9
         bb86tP/LQyS+15+hC1vu3WH5O5OmLzdhly8+mz9L0YvUVWQv03kFIa+T0o2F8J6rUuuA
         K7rjfSsGHSyHkbU9C/hfnjKNFtarMZ5qr5xYxeDK9VB3idMFqkH7CQsNDqbiJsepdIt/
         uqdDSp39wUd3hyG1OfdtZnaeQvrLmAg5nzBZ44Jgg44S1wqsbnkGqBsBnF0BJUcNY/tk
         QXQ1CXB/fNY7U14UxqKLZEvkWG4nTOwD8sIg18WsA1ae30v6X4vcqefo52d72h2jcHLu
         BF8g==
X-Gm-Message-State: APjAAAUfOFytVv3i9HpY3fVQxDCq+wEYkZfurYesS5rKt9bNjN3XZPkB
        vMQqH5yJDb85lawq6CU8vLIwhQ==
X-Google-Smtp-Source: APXvYqyHd8yd/ZfghyYXnSEA9OSdxzY3xq4+j/JRo03ZFZtVG/6FYRHmmczZcRHQYbdtwzlLmdVWvw==
X-Received: by 2002:a0c:b051:: with SMTP id l17mr29818165qvc.96.1554823999222;
        Tue, 09 Apr 2019 08:33:19 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d21sm23628174qtc.91.2019.04.09.08.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:33:18 -0700 (PDT)
Message-ID: <1554823996.26196.48.camel@lca.pw>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
From:   Qian Cai <cai@lca.pw>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Apr 2019 11:33:16 -0400
In-Reply-To: <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
References: <20190406181704.33574-1-cai@lca.pw>
         <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
         <1554816309.26196.46.camel@lca.pw>
         <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 16:54 +0200, Rafael J. Wysocki wrote:
> Fewer jumps are easier to follow in general, so avoiding ones that can
> be avoided is helpful.
> 
> I'm not buying the argument about more code line changes needed if the
> function name changes.  It's meaningless.
> 
> And if you check the return value of acpi_get_table() for SRAT after
> calling acpi_put_table(tbl), you will only need the out_free label, if
> I'm not mistaken.

I don't really understand this.

status = acpi_get_table(ACPI_SIG_SRAT
acpi_put_table(tbl);
status = acpi_get_table(ACPI_SIG_HMAT

If acpi_get_table(ACPI_SIG_SRAT failed, there is no point calling
acpi_put_table(), so what is the point checking return value of acpi_get_table()
for SRAT after acpi_put_table() ?
