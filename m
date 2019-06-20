Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061321537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UcYaJmA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfFTKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:01:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16910 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFTKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:01:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b59640000>; Thu, 20 Jun 2019 03:01:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 03:01:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 03:01:09 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 10:01:07 +0000
Subject: Re: [PATCH v6 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
 <20190620093929.GI26689@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5da5b498-cbc7-26dd-bd68-7f2376eb6b30@nvidia.com>
Date:   Thu, 20 Jun 2019 11:01:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620093929.GI26689@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561024869; bh=qdyhSSt7RMpn1tWpQVWYh3tgNpZcqv4QGKpRxtDW2Sw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UcYaJmA1XyZElfQVXNOZsorTWCrIXlmqn79vGS87RD22Q1z+QjwSDGLGWgSLqlL7j
         jMNjUt5Ev4dBEc2ERU6GuxIVombvS3hCzLGpqKcY9Pas46Xu0a84YgP9j/jzh/+Qiz
         YHBQeNBg1ugBgYT+BDSl67mINDWiEZJBH+WwJ4OWegynqr9u9vGYLAKPdWifKfhcLG
         YV9OpW8ZnPp6LLptYGVhxX9UrC35AJ/zLWM3WRx4p3djRDcauXuvB5BwUrbp+51sgI
         v/2yc0IMR53lhsmEI+YN0wwkeMTfIFF/F/TH6rbX6Fcs7KWWqFI7ShQDCnmLuDU7p6
         BxgsYq28m4AZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/2019 10:39, Thierry Reding wrote:
> On Wed, Jun 19, 2019 at 05:21:21PM +0530, Sameer Pujar wrote:
>> Add DT nodes for following devices on Tegra186 and Tegra194
>>  * ACONNECT
>>  * ADMA
>>  * AGIC
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>  changes in current revision
>>    * updated ranges property for aconnect
>>    * renamed agic node
>>
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
> 
> Applied to for-5.3/arm64/dt, thanks.
> 
> I ended up deciding to put the aconnect node among the nodes with unit-
> addresses, in the numerical order that it would fit in if the top-level
> aconnect node didn't exist. I think that looks much more consistent in
> the end, even though it's slightly bending the rules that we have.

Thanks. Good point, I had not thought that bit through. Works for me,
especially as the aconnect bus has a ranges property and so is
associated with an address range.

Cheers
Jon

-- 
nvpublic
