Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33410C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A923430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ni7eJCNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfH3XFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:05:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33240 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfH3XFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:05:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id go14so3996777plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NI9BDtZfkfrCl+dTZfqEJB4bWNMIfe/Up4Cdd59pL2g=;
        b=ni7eJCNBVuVRlLYnYl2bzjCuTIJPzlxVlk/TLefYHHLlJaJ99uhbajuSFCW/XPipa+
         88fyw05AqcMrAkaMzNX3w04s57ImGDkDpMnAVzWadsFUxcSJVdYZ89Xl7YonchbOXEaD
         PCgVN/r18gqfh33GPPJEYFRZXpR568EKqe3VpFNXH8/1+LFh/khSAvJPmq1OvX+EXc11
         txa2pj+KqMzjtM8hBtBSvFyDJgHGph/S91GzdIgoNntqWC8o6hLFb1aAu1lVmH6PNSbe
         NSBgfEYDyAXL5NxDwJaFjdiLImMSDWj4+Jsjn3anvWPjKg/XlhuH1qHinwqYSs90Rvkg
         IBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NI9BDtZfkfrCl+dTZfqEJB4bWNMIfe/Up4Cdd59pL2g=;
        b=G2Z6KYlP2hGWLD690VWsc8xflyx02IyyszK8CWAmmh5tKpGvkbvODyqQn93RgEBwdg
         e60pwrKhqMyMT1gM4+4iDMBKR+o6HUrmuHOH0r8yQGfhgXue0A0vfN/KIIWu8+lmMzDJ
         TniA2hv4c9jszSMGpbMvKdML0+VG7QJ3lRyk74xiZBXsNYd0HanPUMrU8Xwh+zqZ9kn1
         5BtBR6JqkSPVj6CDKyQkPkStDX7VtJK4/0nUlex0jtQkaoyVgJEHOhSjYn+7JC1PqKJD
         eWRY+exSEqb5seLUx+kZ9P8EsOyIXJMQiSGqtbnoYqud3JiUcJsZFSIQyHBsQ/9pcm76
         H75Q==
X-Gm-Message-State: APjAAAVBOeQaCDeSpb8TIeMc6s8ubt3WEuVbBzomnY/rfKS+s7ca5dgu
        1J8aJWr3Dp1QEUL7T2A1Hqnswg==
X-Google-Smtp-Source: APXvYqzlZrhD2umfyBqhvQCNE0YD3z96OCMV30W6iz0UXOvGDit5ze7lKPsitEvryrSAN2eP6WlPmg==
X-Received: by 2002:a17:902:1107:: with SMTP id d7mr17857245pla.184.1567206315345;
        Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m145sm7947995pfd.68.2019.08.30.16.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:04:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH net-next, 2/2] hv_netvsc: Sync offloading features to VF
 NIC
Message-ID: <20190830160451.43a61cf9@cakuba.netronome.com>
In-Reply-To: <1567136656-49288-3-git-send-email-haiyangz@microsoft.com>
References: <1567136656-49288-1-git-send-email-haiyangz@microsoft.com>
        <1567136656-49288-3-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 03:45:38 +0000, Haiyang Zhang wrote:
> VF NIC may go down then come up during host servicing events. This
> causes the VF NIC offloading feature settings to roll back to the
> defaults. This patch can synchronize features from synthetic NIC to
> the VF NIC during ndo_set_features (ethtool -K),
> and netvsc_register_vf when VF comes back after host events.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Mark Bloch <markb@mellanox.com>

If we want to make this change in behaviour we should change
net_failover at the same time.
