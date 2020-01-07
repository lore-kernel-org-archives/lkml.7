Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80319C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A86207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fi3vK+3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgAGKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:21:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgAGKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578392512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp1B0oryBnzMjpq12qEWIWdEYq7gqXTvQXjEcGcPRhM=;
        b=fi3vK+3Q9t1nHysSns5323qTVNygfJmv8E/nEg39oLma18hzd2d9AvAbN3FDXOsXXnx3u6
        wIdTGEF8vpgABD9MMc+KtnZk+VR4lbXrleDoLOBXwvQufe/QEJH+7B/xO+1pF2glHo+f4V
        1H/GF6P6yMKzyXymloUokKVMHDf90ZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-JEdw7h0IPtqi2Kv3EAfLvg-1; Tue, 07 Jan 2020 05:21:51 -0500
X-MC-Unique: JEdw7h0IPtqi2Kv3EAfLvg-1
Received: by mail-wr1-f72.google.com with SMTP id d8so21944643wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wp1B0oryBnzMjpq12qEWIWdEYq7gqXTvQXjEcGcPRhM=;
        b=SiUYfFrp28KeL1z456qIoD5kpnsU8/cb4AAzb6W9WLoLYfzjn/78A4q5/EHWQZKsJO
         hveSH5/g6IFkeqW/OqpcOB/Qf9BjpoMm+nr9KA+GcYzM3IpAOqQU+5e1rzfSQWtGoEFf
         ynxhOGGPMRWcVLJCbfn+4F6UBTI16GduhqGBveZ3gFoqxLcYBsVJA/grh6UWhzv+ZESm
         rBpxSE2ETN75CToYwmkU5bkuB3IDuSTNCwQxNbApuaZKEZ/Td6k+z4NbXBtJNROy/eY7
         Gc2ngyPnR+rPuRSGyVI11evWTSxzsuiuf9CK+UKK8Ht+0l8cbR/S9L4EQ63S7LXjniW9
         +/Ug==
X-Gm-Message-State: APjAAAX9r0kyCSWG/frHF1rflSx0L0tW4tXAkhEUqBVjUPazi2Pi/GiG
        Qw2dHvCONauNJ3wq7yRtX3vJew5fFz1tFKLVc3YKRAKMunUKE5e6r2JL52zl4th2cA9kU1CrfEH
        IZow0F/FZSSiSoWhikZKWxotm
X-Received: by 2002:a1c:4454:: with SMTP id r81mr38567194wma.117.1578392510125;
        Tue, 07 Jan 2020 02:21:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx7uwkQ39Sba+ZHZ4NO0/8s8bU3zLgUXwYFecjdGGaOLjxxil5G4HRAuahmoDCFBepsAAtOA==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr38567170wma.117.1578392509933;
        Tue, 07 Jan 2020 02:21:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id d16sm81431405wrg.27.2020.01.07.02.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 02:21:49 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/i915/gvt: subsitute kvm_read/write_guest with
 vfio_iova_rw
To:     Yan Zhao <yan.y.zhao@intel.com>, zhenyuw@linux.intel.com
Cc:     alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gvt@eclists.intel.com,
        kevin.tian@intel.com
References: <20200103010055.4140-1-yan.y.zhao@intel.com>
 <20200103010349.4262-1-yan.y.zhao@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5838d595-ba77-5506-4f2a-d555681a9cc5@redhat.com>
Date:   Tue, 7 Jan 2020 11:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200103010349.4262-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/20 02:03, Yan Zhao wrote:
> +	ret = write ? vfio_iova_rw(dev, gpa, buf, len, true) :
> +			vfio_iova_rw(dev, gpa, buf, len, false);
>  
>  	return ret;

"Write" can be just the final argument to vfio_iova_rw, that is

   return vfio_iova_rw(dev, gpa, buf, len, write):

Thanks,

Paolo

