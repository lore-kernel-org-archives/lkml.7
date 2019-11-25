Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7AE2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fpZe+7+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfKYO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:28:13 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:19077
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728016AbfKYO2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:28:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnzM/zopAqpcHzejEnDSgHyyH+kvO9dgBAMf0P6JQ3u6lQeORmdm36eu4pFvCV35pgSNMaHhtknFFtkqQ7B+zIioq/e5uMZwj5cCaMX891I7BQehi5PyjeQUCi/1wzwnS5vPx6RxRaRbcvml/bzMjb3YUGvkUc+krd/rOgCgOtcD+M/xM+7wnw6spDGXv07P3MniQepi+4pw9wYEsemJVTZKQxjIAQI9RZsC3bzcgii/sNwUM1O92diOTVIt7/d2vIB/Jmr4fbCpssVNHMEfsdO00fjcnBgbepkzUhW7Wjl6LdU2VFNoer6oixVCImEAnBeV1FWzp3esNmWjx773Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/9fIBsdcQIb1DfTBD7Su2uYmYkjizqLQdD0liADHo8=;
 b=jQgbsTfM+92Fm81L89sZwU9mm5FUFhv4spl6XlxLXcnVJgfiYdNcUhwNiytJhm8oogG6wSRLzwVdL6n5spjEYDa/Co6bf1zstKTxkgrDZ1pjL8fAQEP3cjA4D1LqP88i+gXfPJRgXgIoSA50Xhzbp0Q7/tXAMqUuCKybiiOPrmjQxVZjFjEnGUUiP00nLJaJKXmSrqMcEiLHxVmdf/MiXCJuFo7rawf2gmku7tlb6cyjUZORslx9MwtzrpaS/+HqpIZmUjwgBcXWv61Vs5kQo9qiYPCxq+gx421MM36f7KR/ZB8yABiSzKyp+aV/RMUEX/CukIPgzhOrshEEHFIq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/9fIBsdcQIb1DfTBD7Su2uYmYkjizqLQdD0liADHo8=;
 b=fpZe+7+PObgrfwBNpPmTyxKbpTSoOnHzdLPQygTDvglIiNi1/8IK72CaZzpqGAksVNPCoNkjpz11Mja5UQl6DCW9sxYaR27sTRn09eWCQQn/BI65qLdSug1WfV95KO0D7MYYh6oiTLFV1rXM70Sgsg2U+hGf09fPwuXruXXXEZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0118.namprd12.prod.outlook.com (10.174.52.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 14:28:07 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 14:28:07 +0000
Subject: Re: [PATCH] drm/amd/display: Use NULL for pointer assignment in
 copy_stream_update_to_stream
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20191123193639.55297-1-natechancellor@gmail.com>
From:   Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <ec7313da-dcdd-8884-063f-bf0e8cc664dd@amd.com>
Date:   Mon, 25 Nov 2019 09:28:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191123193639.55297-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 434245ba-d9e0-4f36-6479-08d771b3b074
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:|CY4PR1201MB0118:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0118BCF64B4EACBC96DCA2918C4A0@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(54906003)(186003)(14454004)(966005)(5660300002)(2906002)(26005)(3846002)(6116002)(6246003)(14444005)(4001150100001)(31696002)(81166006)(81156014)(25786009)(8936002)(8676002)(4326008)(2486003)(76176011)(6486002)(229853002)(6306002)(6512007)(6436002)(50466002)(478600001)(45080400002)(52116002)(23676004)(66476007)(66556008)(6506007)(99286004)(66946007)(11346002)(47776003)(65806001)(65956001)(66066001)(386003)(53546011)(6636002)(230700001)(446003)(58126008)(2616005)(305945005)(316002)(110136005)(7736002)(36756003)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0118;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCnTFU5iV162tXqcgbiCw4TSxpZXhiR1U5Yz7V8nw+687gMol824bceGnIvGzjraNgWrphv/6TqA1NPXnwP59rSRtLdjyf+ZKkYFMGFOaBvjjvg1cl6lBNwBZ1Xfszh4iqgePHAlq5jvvAcUjXTkXkulH2iTdEQ2MzzEilpvoy95Yx83st1jq8f6PwGxRdf+54MX9KfCzxZGh19vTuIIoJ2FvHslKUlykcVL2yGQc3LRNJmorfz/CSscxEaSnTE6W15M2w1+xwTwjBUdfadVmDjEEnssT2xnyR/rI3KezytPETJdogEaZkrxWVdEeKHi0j6Us+iuBcboqRu+4bdnoPeF+yXrqfmv8DOclObU7xS6s9owrER/cvZYQchdIBLKnKZ2SZmZi3SipvkFGBe3DRCB3OQU+SvoQ4Uvvylqc1NSpVV4SUP2oEIQlasMjRg2T3kgJM5+/dbKw5wsO8zno1SSvbtbjJo6jMwj08HBYl8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434245ba-d9e0-4f36-6479-08d771b3b074
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 14:28:07.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DVCLHNsHTkE0yVC6wS3Yxmqh2egWz0lCMotbreHlZfSxhD1Y38yqlXORjCTeX1nECdfYBkA5jAgG2vPKmWfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-23 2:36 p.m., Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1965:26: warning:
> expression which evaluates to zero treated as a null pointer constant of
> type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
>                                 update->dsc_config = false;
>                                                      ^~~~~
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1971:25: warning:
> expression which evaluates to zero treated as a null pointer constant of
> type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
>                         update->dsc_config = false;
>                                              ^~~~~
> 2 warnings generated.
> 
> Fixes: f6fe4053b91f ("drm/amd/display: Use a temporary copy of the current state when updating DSC config")
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F777&amp;data=02%7C01%7Charry.wentland%40amd.com%7Ceb5e55813307456cf7d608d7704c79c4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637101346080296409&amp;sdata=6HK3wWYMoILbiBisjoHkFwopV%2BuJYUh8wCDhMSvRQQ8%3D&amp;reserved=0
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index c7db4f4810c6..2645d20e8c4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1962,13 +1962,13 @@ static void copy_stream_update_to_stream(struct dc *dc,
>  			if (!dc->res_pool->funcs->validate_bandwidth(dc, dsc_validate_context, true)) {
>  				stream->timing.dsc_cfg = old_dsc_cfg;
>  				stream->timing.flags.DSC = old_dsc_enabled;
> -				update->dsc_config = false;
> +				update->dsc_config = NULL;
>  			}
>  
>  			dc_release_state(dsc_validate_context);
>  		} else {
>  			DC_ERROR("Failed to allocate new validate context for DSC change\n");
> -			update->dsc_config = false;
> +			update->dsc_config = NULL;
>  		}
>  	}
>  }
> 
