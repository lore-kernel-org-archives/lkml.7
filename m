Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A3C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33B721872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZY+eGwNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfJVSfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:35:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33463 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJVSfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:35:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so13949514lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dPjuP+VmWSvLVAg6NKGM3Tn3kuQc1C/B6A+vpJASWdY=;
        b=ZY+eGwNS1QBTYwz/CjaNPAO/9O6VCd5l8HjrB1XlkYYK1I9HAT/tr9qxWAVDZnIMy3
         COZ1QAjvsk8hTeflE3BH/PlnIhFWEn/Rm6UySdg7QOhbGZcI6UtNAlydLnRE3SYphZ3V
         e7xZE7D9WZgmpmyfNmfVyDDcGPQIgkJNcrz4W5d2Kx4N4p2uO/u+QZoOjCPM2KDwx/cH
         YsaH3ADlMAlnRjTgo/J11f8iei1l162PDU+pCBuUNceTD6X+xwUs0ggc/pNjRES05xYX
         GVeOFockjWvAoMSD6NiUKuqkK0JhQCf7YwXZK1sjvGhmiUnrHtx0Ts064NF8RtXeXOGH
         2nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dPjuP+VmWSvLVAg6NKGM3Tn3kuQc1C/B6A+vpJASWdY=;
        b=Vis4a1Y2N2a+jzuBNHWU0XtMNwYsNMNhq0vCQ7twRcj89n05ZR5jQoI9uUEMiqPrWu
         0KBkXIUs1LtFSxWyzX2BUCz/Wn+Y5qiKx24tGgNl8shgeUVKLZtccPQqmhhYcOeanpBD
         Apk+oVp0RfrOCM0YWfmYlQWSzo2IXlwJCi7PtlmO4yJEELCANyb2bCoJngnm0rN1+o9q
         Bd3YGv39N2O+eZYQx0aXuOH471y4LyYL0g76swIxfXKnKt0VMe8y2//j3/eNN+ELzS9A
         bGeqm8zfv1fxp1Am6v48fAIPunnUMaBucaEertIVfjSQSQA27wVfr07ufMQMA+n/2CmC
         53bA==
X-Gm-Message-State: APjAAAVYMJI25+/Yhga9M0Gw90r/TcSG80r5XfVaKBoPtOYKR2LTnbT1
        qsPbZr6AyS4oaWBSTv7YO5QFtw==
X-Google-Smtp-Source: APXvYqzhCd56Nx8O4+lldDDoiyHjvdnSJlA1XNHIMqwmMg9D7RLGjAvgsrRnfY16rQphZvyzjEjxXw==
X-Received: by 2002:a19:7516:: with SMTP id y22mr19388885lfe.57.1571769333823;
        Tue, 22 Oct 2019 11:35:33 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t8sm15056191ljd.18.2019.10.22.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 11:35:33 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:35:27 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] xen/netback: cleanup init and deinit code
Message-ID: <20191022113527.6b6bf615@cakuba.netronome.com>
In-Reply-To: <20191021053052.31690-1-jgross@suse.com>
References: <20191021053052.31690-1-jgross@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 07:30:52 +0200, Juergen Gross wrote:
> Do some cleanup of the netback init and deinit code:
> 
> - add an omnipotent queue deinit function usable from
>   xenvif_disconnect_data() and the error path of xenvif_connect_data()
> - only install the irq handlers after initializing all relevant items
>   (especially the kthreads related to the queue)
> - there is no need to use get_task_struct() after creating a kthread
>   and using put_task_struct() again after having stopped it.
> - use kthread_run() instead of kthread_create() to spare the call of
>   wake_up_process().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Paul Durrant <pdurrant@gmail.com>

Applied to net-next, thanks!
