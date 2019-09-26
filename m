Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF94C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F497222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6BslChf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfIZM5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:57:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57890 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:57:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QChmox126209;
        Thu, 26 Sep 2019 12:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wgbB1gckrWIlucivgg+XWAxQa+UFNwnWecELwTVQsJU=;
 b=N6BslChfal8kgvrGAJzkingykcTMlYd1NcnZtth2N9VL1pVIsYFPTg8RxUNyS8GkypHp
 RIyEmIxN54gm6CDxe5GH2oXeEGs/kpwq+JTy+0F/D6RG98QJIdO1avYWfgJ1XHhmeE4O
 wHt8UUyepcfChmtz7nDidi/6x3pnMZXLRNhakCJNxGZ3SSn6FsBjsaTjruKs0A1z4EE2
 izAq6Qs34SNH9yreZ4uVraPfEHO+dnR3VfsJr+k5XwnMTYDUvmMtbNsZkc/0F14eyEUg
 To6gmai5KsPD07idBfG1x3xnzwJiNv7Q0GWMhqnOuToXaRbTCrwazCGEsuhrUJ7DDQpn Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v5btqbhjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 12:55:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QChr1D098396;
        Thu, 26 Sep 2019 12:55:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v8w5ka3gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 12:55:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8QCtooO015468;
        Thu, 26 Sep 2019 12:55:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 05:55:50 -0700
Date:   Thu, 26 Sep 2019 15:55:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] ASoC: amd: ACP powergating should be done by
 controller
Message-ID: <20190926125538.GF29696@kadam>
References: <1569539290-756-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569539290-756-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569539290-756-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 04:37:39AM +0530, Ravulapati Vishnu vardhan rao wrote:
> +static int acp3x_power_on(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +	if (val) {

Flip this around.

	if (!val)
		return 0;

> +		if (!((val & ACP_PGFSM_STATUS_MASK) ==
> +				ACP_POWER_ON_IN_PROGRESS))

Use != insead of !(foo == bar).

	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)

> +			rv_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
> +				acp3x_base + mmACP_PGFSM_CONTROL);
> +		while (true) {
> +			val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +			if (!val)
> +				break;

return 0;



> +			udelay(1);
> +			if (timeout > 500) {

if (timeout++ > 500) {


> +				pr_err("ACP is Not Powered ON\n");

We print two error messages.  :/


> +				ret = -ETIMEDOUT;

return -ETIMOUT;

> +				break;
> +			}
> +			timeout++;
> +		}
> +		if (ret) {
> +			pr_err("ACP is not powered on status:%d\n", ret);
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}

regards,
dan carpenter
