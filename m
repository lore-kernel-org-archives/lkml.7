Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4369C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722F820692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CiUp1ox8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgAHXwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:52:55 -0500
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:6124
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgAHXwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1v3JA1z+ZMA5NMH42GiQzoqWk7ovPFXlYpSsTPVwREJQezsqNiFV8XRe3EzTesFJRbOs22hDxjRbwfeIwUfBGsiAvmH9+IyRj6eHv6x0LJ7HiEdUoZWruJHmDR7ShzKr4J/vBokJixbYtUWgjt609RRxAOQNxzhnInxCWd+OBnyXYpmnrCvmExghinGOCSPuHBz0PoIBO7+NMnhyfLg5j9/JkHqCF1pt85k8RQSTAkRxMwlAKGYDnxmLBa4ERxZS3EKIiRBarLU1HOdpi40FcXPy0GoyHJGl7U+IWYwsDDO4QZ9b9oUZXiPMjLjRIiDKIqIcyqXKVx/ZVenkb1o+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5d3N3h+frDAN9uu8RKQBszr6qlfZICgSSm3zGY1KAw=;
 b=OpvWp25KBSPAKOvp4v731G/BWop7s2TNdF3LwsNxsuSuL1uGSzSzMErBxkMWKDawXSTVFtX4bBjV261PQjeolGKKc9T/TWU0FD3+jkDpQG0dr61IJ5EMWqTE5m7XZV5IkMG5Mo7ML41D31pEawO8aTlnLu9f6I7hGqptI2Hp5MfUjgia0SVIUkbnf6uxUt935ZRzLXpbaLHL+ZAf8CDJAInCsTS6R1dLGPrStzNObBpfrl9FXvTuNRnYnHynf2+AK3JBhvmjUE2MDjUEg/DcUQm0VeWsf0vrvIVCYD+l5BPn1pD9l53WdD0iqaVfKquFBtl8izORKv01K/U5MTiSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5d3N3h+frDAN9uu8RKQBszr6qlfZICgSSm3zGY1KAw=;
 b=CiUp1ox8cVau6NkdOS4QoKWy1xP0X3LF0K9iTTUH8Jz4kwFHUqfZQDM3PVss0kO2VR+FXW+rs2X+p+GuaxumHsRrp4nI9RrORh3e+38i0HUhxi/VxOUudWbA2DEzH9IZp/4+Ou0eh6AeaWH4Ndv3nqhwH1wXt28Mf4FNsOgMx1M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2638.namprd12.prod.outlook.com (52.135.103.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 23:52:51 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 23:52:51 +0000
Subject: Re: [PATCH 1/3] perf vendor events amd: restrict model detection for
 zen1 based processors
To:     Vijay Thakkar <vijaythakkar@me.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-2-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <e2cb90b2-7cd2-122d-6e31-dbca5f1c79a8@amd.com>
Date:   Wed, 8 Jan 2020 17:52:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191227125536.1091387-2-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN4PR0501CA0010.namprd05.prod.outlook.com (2603:10b6:803:40::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.6 via Frontend Transport; Wed, 8 Jan 2020 23:52:50 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bcfa65c-e143-4132-030a-08d79495df1e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:|SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26386606DB12C09228B6301B873E0@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(26005)(66476007)(66556008)(31696002)(478600001)(956004)(4326008)(52116002)(53546011)(186003)(16526019)(2616005)(66946007)(86362001)(5660300002)(81166006)(6486002)(7416002)(110136005)(31686004)(81156014)(2906002)(36756003)(16576012)(8936002)(44832011)(8676002)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2638;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zL5YazyejZ1GQm/Qwkl5n2WkUdbGt80mI7SjY8gEPB0dB4CHve9xkSwFj3mYOWpY/s8YNQ6bRD1BSVbyUNypWhk+DWPn87z0HGFyjBtd5O8kMBVq4raS2C7m6LTz912+l8l96MJFCZgsh+HOuyhhB05cm6Gbsn/MqxWMfSVYu2UT2pf+9mbhyjPvFme3gq4tVUC6SQ0tqsCetX+hvfTgerIrj/VHatJwKVIc+0sTsdfWTFoByAzBJzNZmChrpiD/Qq6XlsX7qMfbEXF7CkjQcB9JxwqQqiM//cF/Qq6UPgPG/2c7V/MQm0mMdKqbVYdpSw5wfvF0lWfzMMoNl2KNvx2WGgCZ1Q9gINiFu1luDpktOWn6zAotZS78D8zbaHYfiejKbQHYeSF4CWqechZUGI5dvkZAwU7oYcFOWp0EhsZ4k+agsU32/YB4x1DyPHu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcfa65c-e143-4132-030a-08d79495df1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 23:52:51.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sv1B1d+3RELz7GmIY+FwAd90+RPBGXeOPFqQqEz6K6Tq6IcytMZZh/DQSFkEoddlOQOM3M+a1c664QLmX0SqiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

I'm just starting to review this...first comments are:

On 12/27/19 6:55 AM, Vijay Thakkar wrote:
> This patch changes the previous blanket detection of AMD Family 17h
> processors to be more specific to Zen1 core based products only by
> replacing model detection regex pattern [[:xdigit:]]+ with [01][18],
> restricting to models 01, 08, 11 and 18 only.

I've asked within AMD to find out if those are the only ones with zen1 cores.

> This change is required to allow for the addition of separate PMU events
> for Zen2 core based models in the following patches as those belong to family
> 17h but have different PMCs. Current PMU events directory has also been
> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.

I'm not sure if this is 100% the way to go.  Technically, the events and their descriptions vary in the per model PPRs, due to things like AMD's validation tests passing.  So historically, we've kept the source of the events for a specific model in its PPR.  I realize that that may not sound very efficient, and in fact would increase redundancy under pmu-events/, but looking at the data volume figures for each of their family names, that is how Intel does it, too.

> Note that although this change does not break PMU counters for existing
> zen1 based systems, it does disable the current set of counters for zen2
> based systems. Counters for zen2 have been added in the following
> patches in this patchset.

Right, and I'd like for the regexes to not be restrictive like this.  Is there a way to get them to be more open to working for unspecified family and model numbers, like the current version is?

> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
> ---
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
>  GenuineIntel-6-7D,v1,icelake,core
>  GenuineIntel-6-7E,v1,icelake,core
>  GenuineIntel-6-86,v1,tremontx,core
> -AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
> +AuthenticAMD-23-[01][18],v1,amdzen1,core

Last but not least, this fails to match on my AuthenticAMD-23-8-2 machine, which gets me no 'perf list' output, when there should be.  I think it is because the regex requires the 0 in front of the 8?

Thanks,

Kim
