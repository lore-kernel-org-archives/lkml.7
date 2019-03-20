Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F5E217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCTAG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:06:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbfCTAG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:06:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JNxYUt058347
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:06:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb85262v3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:06:56 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 20 Mar 2019 00:06:49 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 00:06:46 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K06oBs45547588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 00:06:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EFD552051;
        Wed, 20 Mar 2019 00:06:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 97C455204E;
        Wed, 20 Mar 2019 00:06:49 +0000 (GMT)
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up
 request_trusted_key()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, keyrings@vger.kernel.org
Cc:     James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 20:06:38 -0400
In-Reply-To: <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032000-4275-0000-0000-0000031D04A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032000-4276-0000-0000-0000382B8694
Message-Id: <1553040398.4899.149.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:

< snip >

> +/*
> + * request_trusted_key - request the trusted key
> + *
> + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> + * manages both trusted/encrypted key-types, like the encrypted key type
> + * data, trusted key type data is not visible decrypted from userspace.
> + */
> +static struct key *request_trusted_key(const char *trusted_desc,
> +				const u8 **master_key, size_t *master_keylen)
> +{
> +	struct trusted_key_payload *tpayload;
> +	struct key_type *type;
> +	struct key *tkey;
> +
> +	type = key_type_lookup("trusted");

The associated key_type_put() will need to be called.

> +	if (IS_ERR(type)) {
> +		tkey = (struct key *)type;
> +		goto error;
> +	}
> +	tkey = request_key(type, trusted_desc, NULL);
> +	if (IS_ERR(tkey))
> +		goto error;
> +
> +	down_read(&tkey->sem);
> +	tpayload = tkey->payload.data[0];
> +	*master_key = tpayload->key;
> +	*master_keylen = tpayload->key_len;
> +error:
> +	return tkey;
> +}
> +



> diff --git a/security/keys/key.c b/security/keys/key.c
> index 696f1c092c50..9045b62afb04 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
>  found_kernel_type:
>  	return ktype;
>  }
> +EXPORT_SYMBOL_GPL(key_type_lookup);

Only the kernel is calling key_type_lookup().  Why does
key_type_lookup() need to be exported?

Mimi

>  
>  void key_set_timeout(struct key *key, unsigned timeout)
>  {
> 

