Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5002084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MqnTR4Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFTXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:53:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35951 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:53:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so2054871plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fp0ZtYWqWsiKMMkGKYexvg5EbTvON0HXd5h9Im2In88=;
        b=MqnTR4IqFtQc2OTdYSIns9YM6ANvfKzyuf0TyX4dKE/beockvQc632WP1hHVKQoWus
         4W/RhxwbMSfNfUNWnb09wG6kURarVqKbcvFIZnEGRciQ6TN8EYcYOA7LinerHrakwT9R
         ndlw73dYVk4mrOhaA7QTKs5q9DxCmwWTaKgDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fp0ZtYWqWsiKMMkGKYexvg5EbTvON0HXd5h9Im2In88=;
        b=qdKQyZNM/NaBqoVURsIuh/NPTKCXgcYzvYdlvXCIYuqddjCCxQRD75lJf5haTlmtwY
         RqsPxXir6VU52W/DB4qJUe7CloB3XSpL2Vk3z73nWgJn5fiboLxHRThrq67MuI6MNUv6
         cgNeUlwnj9bTRaiGPHtnrawQiKKG9+EiDCcJhtjK8IONL9SVKz8roAO7cqkA7RDNhT7R
         CVBx2bGwHdGuV0JtDNXrX3e88bAOnvrXVYE2lb4wi3+9+YQkLqT2Vw1SDVpqThHs2tuv
         /cqhQkYkhfv7Tu6M8Zotd6CHy3bwCQEZinM4FBGB8ExY/TyU+/FZAJFhmT1TbM9Ge+ME
         +eMw==
X-Gm-Message-State: APjAAAU28GTkaTrx5w41O0xiIj4d/4pUTSOBAF6Z7MBRYabjK6IphXzZ
        jTAfepBUmeeOj3nA1cKgFkxbcA==
X-Google-Smtp-Source: APXvYqzsOLms4jAiCQ/1lB8IoyemUiFtxiUqzoDNLCKXzDUoLa2IeKt9zb0amJcaqV2xpG7LN4MJJQ==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr105813294plb.24.1561074792495;
        Thu, 20 Jun 2019 16:53:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m19sm14994187pjn.3.2019.06.20.16.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 16:53:11 -0700 (PDT)
Date:   Thu, 20 Jun 2019 16:53:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v9] Bluetooth: btqca: inject command complete event
 during fw download
Message-ID: <20190620235310.GA137143@google.com>
References: <20190528214322.171922-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190528214322.171922-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:43:22PM -0700, Matthias Kaehlcke wrote:
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Latest qualcomm chips are not sending an command complete event for
> every firmware packet sent to chip. They only respond with a vendor
> specific event for the last firmware packet. This optimization will
> decrease the BT ON time. Due to this we are seeing a timeout error
> message logs on the console during firmware download. Now we are
> injecting a command complete event once we receive an vendor specific
> event for the last RAM firmware packet.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

ping

This patch has been floating around in different versions since the
end of 2018 without receiving much attention. If maintainers don't
like it let's discuss how to improve it, just ignoring it isn't really
helpful.

Thanks

Matthias
