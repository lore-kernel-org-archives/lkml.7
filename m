Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834F1215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfK0UjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbfK0UjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARKapsm011375
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:39:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxr0xej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:39:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Nov 2019 20:39:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Nov 2019 20:39:00 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARKcxtt59375626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 20:38:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 685C7A404D;
        Wed, 27 Nov 2019 20:38:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52D1BA4051;
        Wed, 27 Nov 2019 20:38:58 +0000 (GMT)
Received: from dhcp-9-31-103-87.watson.ibm.com (unknown [9.31.103.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Nov 2019 20:38:58 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 27 Nov 2019 15:38:57 -0500
In-Reply-To: <20191127025212.3077-2-nramas@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112720-0008-0000-0000-0000033918B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112720-0009-0000-0000-00004A58227A
Message-Id: <1574887137.4793.346.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=3 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

Janne Karhunen is defining an IMA workqueue in order to more
frequently update the on disk security xattrs.  The Subject line on
this patch needs to be more explicit (eg. define workqueue for early
boot "key" measurements).

On Tue, 2019-11-26 at 18:52 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system before IMA is initialized

Keys created or updated before a custom policy is loaded are currently
not measured.

> should be queued up. And, keys (including any queued ones)
> should be processed when IMA initialization is completed.
> 
> This patch defines functions to queue and dequeue keys for
> measurement. A flag namely ima_process_keys_for_measurement
> is used to check if the key should be queued or should be
> processed immediately.
> 
> ima_policy_flag cannot be relied upon to make queuing decision
> because ima_policy_flag will be set to 0 when either IMA is
> not initialized or when the IMA policy itself is empty.

I'm not sure why you want to differentiate between IMA being
initialized vs. an empty policy.  I would think you would want to know
when a custom policy has been loaded.

Until ima_update_policy() is called, "ima_rules" points to the
architecture specific and configured policy rules, which are
persistent, and the builtin policy rules.  Once a custom policy is
loaded, "ima_rules" points to the architecture specific, configured,
and custom policy rules.

I would define a function that determines whether or not a custom
policy has been loaded.

(I still need to review adding/removing from the queue.)

> 
> @@ -27,14 +154,14 @@
>   * The payload data used to instantiate or update the key is measured.
>   */
>  void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> -				   const void *payload, size_t plen,
> +				   const void *payload, size_t payload_len,
>  				   unsigned long flags, bool create)

This "hunk" and subsequent one seem to be just a variable name change.
 It has nothing to do with queueing "key" measurements and shouldn't
be included in this patch.

Mimi

>  {
>  	/* Only asymmetric keys are handled by this hook. */
>  	if (key->type != &key_type_asymmetric)
>  		return;
>  
> -	if (!payload || (plen == 0))
> +	if (!payload || (payload_len == 0))
>  		return;
>  
>  	/*
> @@ -52,7 +179,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	 * if the IMA policy is configured to measure a key linked
>  	 * to the given keyring.
>  	 */
> -	process_buffer_measurement(payload, plen,
> +	process_buffer_measurement(payload, payload_len,
>  				   keyring->description, KEY_CHECK, 0,
>  				   keyring->description);
>  }


