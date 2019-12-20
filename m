Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ADC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08C720716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHnTldAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLTJXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:23:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727125AbfLTJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576833812;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=760AfQkQ+/CcCELjUM/zRv4ukeCCbW4IzvgFsX0Yv7E=;
        b=fHnTldAMSMXbvv0B4jM0ei7mJM2uzACZBkiXCYWGJq0uMr2xeC4NKc1gYAMqbJrNIetfi1
        k/Y51StfIc5VwhbMqNAScBVF4zhfDIzpz70ue1UB9INRoQSWSrDgbZ/0rYPpmxMnEE35rs
        y7uJSWv6nnh0Bosak5nSx8c4HTkb5f0=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-O0rbJNYRMbiynE5cIkF7mg-1; Fri, 20 Dec 2019 04:23:30 -0500
X-MC-Unique: O0rbJNYRMbiynE5cIkF7mg-1
Received: by mail-yw1-f69.google.com with SMTP id o200so6142854ywd.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=760AfQkQ+/CcCELjUM/zRv4ukeCCbW4IzvgFsX0Yv7E=;
        b=IeZorCZ9e9T24lfMnYPSiCTMEcJKA/hT7dCTWEJNCpKEL364hkW5do0lT+r0Zghl4v
         0Hp0GBLw7vNgMO6KAqzwrmH145klgAaVpjgjO2PW/TIQXUUzR45c4uYBRXyK697Iwqgz
         Hq+quFeLcH4qMHckmYaheVhjAFj6AMpjFKDcccKDRH8Gr4MRn6lWPBPvFvRQepfwvDOy
         cn7JVexGKACxrd7y939Z68XbTo4Jy+EEgfBoMLyPHdqPIdYBXB/lzRaSt1G7GbD4Ca2q
         PUmJm93hX5JFRZ0soXzvXsjBkb6hJKumROLA3FcmPkQoUUIqrUsK8bjCcA6B2PRSjHJx
         zURw==
X-Gm-Message-State: APjAAAWm0dSTLeMZjpBf9/TZb+a0/4wRy3Mwov70QIt2n16GgkBVFTBv
        CiUP57yYW3RrCAw7tDrDJgYZg/UpsrLoGb3A12xfL0jF5b1YHL2dlrktrfmVq2Qd1I7OqANtro7
        /QhqgExie8Fw7a/PpFwk+WX2p
X-Received: by 2002:a81:3e12:: with SMTP id l18mr4149665ywa.210.1576833809895;
        Fri, 20 Dec 2019 01:23:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqgiOGz0PxbzXPELzhJrV+QuQMDpbMDOBSl8JJseKtGExzTwa/TU3Ync2h/zYFnA3lZ+KkHg==
X-Received: by 2002:a81:3e12:: with SMTP id l18mr4149654ywa.210.1576833809529;
        Fri, 20 Dec 2019 01:23:29 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a202sm3705752ywe.8.2019.12.20.01.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 01:23:28 -0800 (PST)
Date:   Fri, 20 Dec 2019 02:23:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     jimyan <jimyan@baidu.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
Message-ID: <20191220092327.do34gtk3lcafzr6q@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: jimyan <jimyan@baidu.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 20 19, jimyan wrote:
>On a system with an Intel PCIe port configured as a nvme host device, iommu
>initialization fails with
>
>    DMAR: Device scope type does not match for 0000:80:00.0
>
>This is because the DMAR table reports this device as having scope 2
>(ACPI_DMAR_SCOPE_TYPE_BRIDGE):
>

Isn't that a problem to be fixed in the DMAR table then?

>but the device has a type 0 PCI header:
>80:00.0 Class 0600: Device 8086:2020 (rev 06)
>00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
>
>VT-d works perfectly on this system, so there's no reason to bail out
>on initialization due to this apparent scope mismatch. Add the class
>0x600 ("PCI_CLASS_BRIDGE_HOST") as a heuristic for allowing DMAR
>initialization for non-bridge PCI devices listed with scope bridge.
>
>Signed-off-by: jimyan <jimyan@baidu.com>
>---
> drivers/iommu/dmar.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>index eecd6a421667..9faf2f0e0237 100644
>--- a/drivers/iommu/dmar.c
>+++ b/drivers/iommu/dmar.c
>@@ -244,6 +244,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
> 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
> 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
>+			  info->dev->class >> 8 != PCI_CLASS_BRIDGE_HOST &&
> 		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
> 			pr_warn("Device scope type does not match for %s\n",
> 				pci_name(info->dev));
>-- 
>2.11.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

