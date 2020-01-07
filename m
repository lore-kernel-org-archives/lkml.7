Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94BFC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA12072C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2F8KdF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAGB6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:58:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727326AbgAGB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578362284;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=jyQyCUdnm21nxv/X1v85w0ZZB+IptGrVE4iTgTEdowY=;
        b=K2F8KdF59WslLGCoBOYJwvW+K96YrABLZegDlt8P0zvioG9MnPP1DVd/Gr/CLMI/+wnys2
        O6jCsxyELXMaqtD8kb9+j+2CaEiv7b4Kd3oxpCBP3VWOBsoDEDQYs5SHetcnggeNIOBd04
        4LPPVZZB86awq/CUsH/jni4S1YkUA98=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-YqTnCHOlODCXsUF4qOXgwg-1; Mon, 06 Jan 2020 20:58:03 -0500
X-MC-Unique: YqTnCHOlODCXsUF4qOXgwg-1
Received: by mail-yw1-f71.google.com with SMTP id w4so5780549ywa.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jyQyCUdnm21nxv/X1v85w0ZZB+IptGrVE4iTgTEdowY=;
        b=WUoAKaPRkwqlLkTzuo0WPLZt8cbvaNLA7+FaLQRs4r2BXE24k6ZfgiZVKaq1fZjQRM
         dGzf162lCdxOEByr4IrvpI0mThQuREB3qZiSRAawfyKF/CFW9B8YPH3k7EZKcYpXRdd2
         4WAUWs7iQcdqdEuJ68SQhTLW6Dn90FlAFUM5Y7JZEvj8JXWm1MB3JEasKKLZU6Wk9Abi
         tQjNRGbEXVBsOoNdGRXGoU4ChGzgUVsCR+O5aXsNsEHnj4Otbhr5eZ1pJBty13RaVbUk
         HuPvUB1xvHunk12hyZvLKfb84Le1v91o+AciP50I/HRwUdag/PqyILF4ekwD+1fT6+HC
         RYug==
X-Gm-Message-State: APjAAAV+w3PWcknB9IhjpDfqJYSxL9rsCvCSfstyYOnL9VBLnznwJ4nr
        QDt6ql6oJdk0Blv+c7VvZFC7uyjqDPZ2MedxWVHMjpdAEc7ricI0CFiL/BxDzbIJbf9jRs4ltLI
        mkaGM0uIChFh/epT9rUVOs/Fy
X-Received: by 2002:a81:f006:: with SMTP id p6mr66574903ywm.483.1578362282069;
        Mon, 06 Jan 2020 17:58:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvqRFkGDxsrJ+8LLIv4naaR8AKOgbQL4pZweIB3X64AP5RS7nGjPUpBAxMM3lmB2/+XMItGg==
X-Received: by 2002:a81:f006:: with SMTP id p6mr66574880ywm.483.1578362281516;
        Mon, 06 Jan 2020 17:58:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p1sm30612444ywh.74.2020.01.06.17.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:58:00 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:57:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     jimyan <jimyan@baidu.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com, roland@purestorage.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Don't reject nvme host due to scope
 mismatch
Message-ID: <20200107015759.ukyt73lmdj6rv4eh@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: jimyan <jimyan@baidu.com>, joro@8bytes.org,
        baolu.lu@linux.intel.com, roland@purestorage.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jan 05 20, jimyan wrote:
>On a system with an Intel PCIe port configured as a nvme host device, iommu
>initialization fails with
>
>    DMAR: Device scope type does not match for 0000:80:00.0
>
>This is because the DMAR table reports this device as having scope 2
>(ACPI_DMAR_SCOPE_TYPE_BRIDGE):
>
>but the device has a type 0 PCI header:
>80:00.0 Class 0600: Device 8086:2020 (rev 06)
>00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
>
>VT-d works perfectly on this system, so there's no reason to bail out
>on initialization due to this apparent scope mismatch. Add the class
>0x06 ("PCI_BASE_CLASS_BRIDGE") as a heuristic for allowing DMAR
>initialization for non-bridge PCI devices listed with scope bridge.
>
>Signed-off-by: jimyan <jimyan@baidu.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

