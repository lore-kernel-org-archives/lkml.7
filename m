Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866720885
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nrjic0b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfKSOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:18:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfKSOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:18:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJEE7LC179048;
        Tue, 19 Nov 2019 14:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9axEBLXvj4bEnlBdKi9wA/X7OLcK/RilJpfkNrxlABU=;
 b=nrjic0b/IL0yHUl6tYQJ+1JjgqN9GEbl1vBlt09+UgdkckeqHhrYsVKzdc12+IkP/F04
 geD9Wy6y7OBdUjS7R5kjugU5ZrK1GQ+/UBAO1SzEInHYPw5GO++7wkSoCP73y9sgCqtG
 JhMB24xq7hSp+NXcCjLEFfw8sDsOL0OTh9s9+gYkU3V31DviUjPgkUFuHonVb89sIGIK
 PW5r4AGhYbtFqPPVVX28tT+lrks3wRthnqMS1UZCheYwkf2STc7ubv/VpgfnARA75b4S
 M4cV+AEHn3iDbhL/QK7iwbN6Ocxg+pegrgYr6mq7P+kRCR0Yu4Y5PCnIugNOBaleI+DE HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htq6eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 14:16:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJEE2RY013345;
        Tue, 19 Nov 2019 14:16:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wc0agf6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 14:16:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJEGkkS023554;
        Tue, 19 Nov 2019 14:16:46 GMT
Received: from kadam (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 06:16:45 -0800
Date:   Tue, 19 Nov 2019 17:16:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/6] ASoC: amd:Create multiple I2S platform device
 endpoint
Message-ID: <20191119141628.GD30789@kadam>
References: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574172508-26546-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574172508-26546-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=984
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 07:38:23PM +0530, Ravulapati Vishnu vardhan rao wrote:
> @@ -56,10 +56,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  		irqflags = 0;
>  
>  	addr = pci_resource_start(pci, 0);
> -	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> +	adata->acp3x_base = devm_ioremap(&pci->dev, addr,
> +					pci_resource_len(pci, 0));
>  	if (!adata->acp3x_base) {
>  		ret = -ENOMEM;
> -		goto release_regions;
> +		goto disable_msi;

This is a bug fix.  :)

>  	}
>  	pci_set_master(pci);
>  	pci_set_drvdata(pci, adata);

This patch is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

