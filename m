Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE2F20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556818469;
	bh=k1Mng5fkxG2kqXsRSaQDBN/3qrjtIBnMdTR42nRFITQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K0p/F1aweWkbBx2cQfEY3d5B29xJVWburQMsDTigiTFZmUdKlsh7tn5KuW5PD17kK
	 SAa69mHaktmA3VZGTmoNVkyff4MNyfwOlehQBzs0AwjzNn4TzUQmUqNN8H0hNz80pq
	 BHTR+GeboKrhXksqg5dZKU27qvCsYn+NlZ1G29C4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEBRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfEBRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:34:26 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09C5205F4;
        Thu,  2 May 2019 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556818466;
        bh=k1Mng5fkxG2kqXsRSaQDBN/3qrjtIBnMdTR42nRFITQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp6CAJKtym6IoN734hnJoB9bKolzpSd0R7qRYpUjsgNKYsINuqSetNrT1/y1xcNaN
         6xMHqCPis63NBoZhcvCRXmKfvQQYWd1l/DP9A5DA3xV1FqO6dXcr1bM8eS8DJT8DaH
         JFX5NmJuqQJsTHn1vYCIS0QS8K+KpZZYBJoG9Pjs=
Date:   Thu, 2 May 2019 13:34:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        keith.busch@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, thomas.lendacky@amd.com,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        jglisse@redhat.com, david@redhat.com
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
Message-ID: <20190502173419.GA3048@sasha-vm>
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190501191846.12634-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:18:46PM -0400, Pavel Tatashin wrote:
>It is now allowed to use persistent memory like a regular RAM, but
>currently there is no way to remove this memory until machine is
>rebooted.
>
>This work expands the functionality to also allows hotremoving
>previously hotplugged persistent memory, and recover the device for use
>for other purposes.
>
>To hotremove persistent memory, the management software must first
>offline all memory blocks of dax region, and than unbind it from
>device-dax/kmem driver. So, operations should look like this:
>
>echo offline > echo offline > /sys/devices/system/memory/memoryN/state

This looks wrong :)

--
Thanks,
Sasha
