Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFE2214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kw6bzlcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCRFHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 01:07:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfCRFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 01:07:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I54w7U160643;
        Mon, 18 Mar 2019 05:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FQsgY/rC6Qiy7ZcTiGJ9kFKdxNCtt7Ss+pz17tBA+Bw=;
 b=kw6bzlcxVqlX58ykk9L9+NegD4qIC8454GyPqELCfHv5vj8px1I2ghcxeFwK0Bsn3FkC
 jhWYnLcQHzd/ETitayDSnRtg56ofvwoH8+OIx08yTl1o3yaOWUL8oymlK6Lsr/oG5006
 x5zqLoXen2sjhhXwJWCkA4FxzqOZKo5coteZP4DUiRCtp6dEa+VhzibwQ3comIurtXAm
 AsIPxEwVijabLesgpUloF3r1TeS+41tJUUutI6uvaZHd0fEmaq1NHg7n6kN2QxgjaXEi
 vZBTN+8+AunPqMMKFZrUHO6rVd2c5zZxez8skDjYLvxzJw4yFbIlMhLMb6vO/hzysejw tw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjuc8nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 05:06:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2I56oUL021678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 05:06:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2I56oTO031094;
        Mon, 18 Mar 2019 05:06:50 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 22:06:50 -0700
Subject: Re: [BUG] scsi: ses: out of bound accessing in
 ses_enclosure_data_process
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, diego.gonzalez@oracle.com
References: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
 <yq1k1gwkc6x.fsf@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5cc39d77-4a88-1449-6d5a-c0735db63dfb@oracle.com>
Date:   Mon, 18 Mar 2019 13:09:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <yq1k1gwkc6x.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

Thanks for your kindly response.

On 3/18/19 1:01 PM, Martin K. Petersen wrote:
> 
> Jianchao,
> 
>> When our customer probe the lpfc devices, they encountered odd memory
>> corruption issues, and we get 'out of bound' access warning at
>> following position after open KASAN
> 
> Please provide the output of:
> 
> # sg_ses -p 1 /dev/sgN
> # sg_ses -p 7 /dev/sgN
> 
> for the enclosure device in question.

OK, I will send this to customer.
And share the result here after get feedback.

Thanks
Jianchao
