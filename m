Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FBEC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D8222B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgACXZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:25:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgACXZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:25:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003NMNm5140940
        for <linux-kernel@vger.kernel.org>; Fri, 3 Jan 2020 18:25:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xa48mh207-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 18:25:08 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 3 Jan 2020 23:25:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 23:25:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003NP2xF40501492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 23:25:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E433242041;
        Fri,  3 Jan 2020 23:25:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED72042049;
        Fri,  3 Jan 2020 23:24:59 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.213.131])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Jan 2020 23:24:59 +0000 (GMT)
Date:   Fri, 3 Jan 2020 15:24:57 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        pratik.sampat@in.ibm.com
Subject: Re: [RFC 1/3] powerpc/powernv: Interface to define support and
 preference for a SPR
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20191204093255.11849-1-psampat@linux.ibm.com>
 <20191204093255.11849-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204093255.11849-2-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20010323-0016-0000-0000-000002DA4B81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010323-0017-0000-0000-0000333CBA1A
Message-Id: <20200103232457.GH5556@oc0525413822.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_06:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001030211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:02:53PM +0530, Pratik Rajesh Sampat wrote:
> Define a bitmask interface to determine support for the Self Restore,
> Self Save or both.
> 
> Also define an interface to determine the preference of that SPR to
> be strictly saved or restored or encapsulated with an order of preference.
> 
> The preference bitmask is shown as below:
> ----------------------------
> |... | 2nd pref | 1st pref |
> ----------------------------
> MSB			  LSB
> 
> The preference from higher to lower is from LSB to MSB with a shift of 8
> bits.
> Example:
> Prefer self save first, if not available then prefer self
> restore
> The preference mask for this scenario will be seen as below.
> ((SELF_RESTORE_STRICT << PREFERENCE_SHIFT) | SELF_SAVE_STRICT)
> ---------------------------------
> |... | Self restore | Self save |
> ---------------------------------
> MSB			        LSB
> 
> Finally, declare a list of preferred SPRs which encapsulate the bitmaks
> for preferred and supported with defaults of both being set to support
> legacy firmware.
> 
> This commit also implements using the above interface and retains the
> legacy functionality of self restore.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 325 +++++++++++++++++++++-----
>  1 file changed, 269 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 78599bca66c2..d38b8b6dcbce 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -32,9 +32,106 @@
>  #define P9_STOP_SPR_MSR 2000
>  #define P9_STOP_SPR_PSSCR      855
> 
> +/* Interface for the stop state supported and preference */
> +#define SELF_RESTORE_TYPE    0
> +#define SELF_SAVE_TYPE       1
> +
> +#define NR_PREFERENCES    2
> +#define PREFERENCE_SHIFT  8
> +#define PREFERENCE_MASK   0xff
> +
> +#define UNSUPPORTED         0x0
> +#define SELF_RESTORE_STRICT 0x01
> +#define SELF_SAVE_STRICT    0x10
> +
> +/*
> + * Bitmask defining the kind of preferences available.
> + * Note : The higher to lower preference is from LSB to MSB, with a shift of
> + * 8 bits.

A minor comment.

Is there a reason why shift is 8?  Shift of 4 must be sufficient,
and a mask of '0xf' should do. And SELF_SAVE_STRICT can be 0x2.



> + * ----------------------------
> + * |    | 2nd pref | 1st pref |
> + * ----------------------------
> + * MSB			      LSB
> + */
> +/* Prefer Restore if available, otherwise unsupported */
> +#define PREFER_SELF_RESTORE_ONLY	SELF_RESTORE_STRICT
> +/* Prefer Save if available, otherwise unsupported */
> +#define PREFER_SELF_SAVE_ONLY		SELF_SAVE_STRICT
> +/* Prefer Restore when available, otherwise prefer Save */
> +#define PREFER_RESTORE_SAVE		((SELF_SAVE_STRICT << \
> +					  PREFERENCE_SHIFT)\
> +					  | SELF_RESTORE_STRICT)
> +/* Prefer Save when available, otherwise prefer Restore*/
> +#define PREFER_SAVE_RESTORE		((SELF_RESTORE_STRICT <<\
> +					  PREFERENCE_SHIFT)\
> +					  | SELF_SAVE_STRICT)
>  static u32 supported_cpuidle_states;
>  struct pnv_idle_states_t *pnv_idle_states;
>  int nr_pnv_idle_states;
> +/* Caching the lpcr & ptcr support to use later */
> +static bool is_lpcr_self_save;
> +static bool is_ptcr_self_save;

I understand why you need to track the status of PTCR register.
But its not clear, why LPCR register's save status need to be tracked?


> +
> +struct preferred_sprs {
> +	u64 spr;
> +	u32 preferred_mode;
> +	u32 supported_mode;
> +};
> +
> +struct preferred_sprs preferred_sprs[] = {
> +	{
> +		.spr = SPRN_HSPRG0,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_LPCR,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_PTCR,
> +		.preferred_mode = PREFER_SAVE_RESTORE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_HMEER,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_HID0,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = P9_STOP_SPR_MSR,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = P9_STOP_SPR_PSSCR,
> +		.preferred_mode = PREFER_SAVE_RESTORE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_HID1,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_HID4,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_HID5,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	}
> +};

What determines the list of registers tracked in this table?


.snip..

-- 
Ram Pai

