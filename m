Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF35C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC26227FE6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFCJYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFCJYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096340"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:12 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 2/7] mei: docs: move iamt docs to a iamt.rst file
Date:   Mon,  3 Jun 2019 12:14:01 +0300
Message-Id: <20190603091406.28915-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel amt documentation to a seprate file.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/iamt.rst  | 106 +++++++++++++++++++++++++
 Documentation/driver-api/mei/index.rst |   1 +
 Documentation/driver-api/mei/mei.rst   | 100 -----------------------
 3 files changed, 107 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/driver-api/mei/iamt.rst

diff --git a/Documentation/driver-api/mei/iamt.rst b/Documentation/driver-api/mei/iamt.rst
new file mode 100644
index 000000000000..6dcf5b16e958
--- /dev/null
+++ b/Documentation/driver-api/mei/iamt.rst
@@ -0,0 +1,106 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Intel(R) Active Management Technology (Intel AMT)
+=================================================
+
+Prominent usage of the Intel ME Interface is to communicate with Intel(R)
+Active Management Technology (Intel AMT) implemented in firmware running on
+the Intel ME.
+
+Intel AMT provides the ability to manage a host remotely out-of-band (OOB)
+even when the operating system running on the host processor has crashed or
+is in a sleep state.
+
+Some examples of Intel AMT usage are:
+   - Monitoring hardware state and platform components
+   - Remote power off/on (useful for green computing or overnight IT
+     maintenance)
+   - OS updates
+   - Storage of useful platform information such as software assets
+   - Built-in hardware KVM
+   - Selective network isolation of Ethernet and IP protocol flows based
+     on policies set by a remote management console
+   - IDE device redirection from remote management console
+
+Intel AMT (OOB) communication is based on SOAP (deprecated
+starting with Release 6.0) over HTTP/S or WS-Management protocol over
+HTTP/S that are received from a remote management console application.
+
+For more information about Intel AMT:
+http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
+
+
+Intel AMT Applications
+======================
+
+	1) Intel Local Management Service (Intel LMS)
+
+	   Applications running locally on the platform communicate with Intel AMT Release
+	   2.0 and later releases in the same way that network applications do via SOAP
+	   over HTTP (deprecated starting with Release 6.0) or with WS-Management over
+	   SOAP over HTTP. This means that some Intel AMT features can be accessed from a
+	   local application using the same network interface as a remote application
+	   communicating with Intel AMT over the network.
+
+	   When a local application sends a message addressed to the local Intel AMT host
+	   name, the Intel LMS, which listens for traffic directed to the host name,
+	   intercepts the message and routes it to the Intel MEI.
+	   For more information:
+	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
+	   Under "About Intel AMT" => "Local Access"
+
+	   For downloading Intel LMS:
+	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
+
+	   The Intel LMS opens a connection using the Intel MEI driver to the Intel LMS
+	   firmware feature using a defined UUID and then communicates with the feature
+	   using a protocol called Intel AMT Port Forwarding Protocol (Intel APF protocol).
+	   The protocol is used to maintain multiple sessions with Intel AMT from a
+	   single application.
+
+	   See the protocol specification in the Intel AMT Software Development Kit (SDK)
+	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
+	   Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
+	   => "Information for Intel(R) vPro(TM) Gateway Developers"
+	   => "Description of the Intel AMT Port Forwarding (APF) Protocol"
+
+	2) Intel AMT Remote configuration using a Local Agent
+
+	   A Local Agent enables IT personnel to configure Intel AMT out-of-the-box
+	   without requiring installing additional data to enable setup. The remote
+	   configuration process may involve an ISV-developed remote configuration
+	   agent that runs on the host.
+	   For more information:
+	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
+	   Under "Setup and Configuration of Intel AMT" =>
+	   "SDK Tools Supporting Setup and Configuration" =>
+	   "Using the Local Agent Sample"
+
+	   An open source Intel AMT configuration utility,	implementing a local agent
+	   that accesses the Intel MEI driver, can be found here:
+	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
+
+
+Intel AMT OS Health Watchdog
+============================
+
+The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
+Whenever the OS hangs or crashes, Intel AMT will send an event
+to any subscriber to this event. This mechanism means that
+IT knows when a platform crashes even when there is a hard failure on the host.
+
+The Intel AMT Watchdog is composed of two parts:
+	1) Firmware feature - receives the heartbeats
+	   and sends an event when the heartbeats stop.
+	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
+	   configures the watchdog and sends the heartbeats.
+
+The Intel iAMT watchdog MEI driver uses the kernel watchdog API to configure
+the Intel AMT Watchdog and to send heartbeats to it. The default timeout of the
+watchdog is 120 seconds.
+
+If the Intel AMT is not enabled in the firmware then the watchdog client won't enumerate
+on the me client bus and watchdog devices won't be exposed.
+
+---
+linux-mei@linux.intel.com
diff --git a/Documentation/driver-api/mei/index.rst b/Documentation/driver-api/mei/index.rst
index 35c1117d8366..d261afac6852 100644
--- a/Documentation/driver-api/mei/index.rst
+++ b/Documentation/driver-api/mei/index.rst
@@ -20,3 +20,4 @@ Intel(R) Management Engine Interface (Intel(R) MEI)
 
    mei
    mei-client-bus
+   iamt
diff --git a/Documentation/driver-api/mei/mei.rst b/Documentation/driver-api/mei/mei.rst
index 5aa3a5e6496a..c7f10a4b46ff 100644
--- a/Documentation/driver-api/mei/mei.rst
+++ b/Documentation/driver-api/mei/mei.rst
@@ -17,33 +17,6 @@ Each Intel ME feature (Intel ME Client) is addressed by a GUID/UUID and
 each client has its own protocol. The protocol is message-based with a
 header and payload up to 512 bytes.
 
-Prominent usage of the Intel ME Interface is to communicate with Intel(R)
-Active Management Technology (Intel AMT) implemented in firmware running on
-the Intel ME.
-
-Intel AMT provides the ability to manage a host remotely out-of-band (OOB)
-even when the operating system running on the host processor has crashed or
-is in a sleep state.
-
-Some examples of Intel AMT usage are:
-   - Monitoring hardware state and platform components
-   - Remote power off/on (useful for green computing or overnight IT
-     maintenance)
-   - OS updates
-   - Storage of useful platform information such as software assets
-   - Built-in hardware KVM
-   - Selective network isolation of Ethernet and IP protocol flows based
-     on policies set by a remote management console
-   - IDE device redirection from remote management console
-
-Intel AMT (OOB) communication is based on SOAP (deprecated
-starting with Release 6.0) over HTTP/S or WS-Management protocol over
-HTTP/S that are received from a remote management console application.
-
-For more information about Intel AMT:
-http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-
-
 Intel MEI Driver
 ================
 
@@ -169,82 +142,9 @@ The Intel MEI Driver supports the following IOCTL commands:
 	in order to receive an event
 
 
-Intel ME Applications
-=====================
-
-	1) Intel Local Management Service (Intel LMS)
-
-	   Applications running locally on the platform communicate with Intel AMT Release
-	   2.0 and later releases in the same way that network applications do via SOAP
-	   over HTTP (deprecated starting with Release 6.0) or with WS-Management over
-	   SOAP over HTTP. This means that some Intel AMT features can be accessed from a
-	   local application using the same network interface as a remote application
-	   communicating with Intel AMT over the network.
-
-	   When a local application sends a message addressed to the local Intel AMT host
-	   name, the Intel LMS, which listens for traffic directed to the host name,
-	   intercepts the message and routes it to the Intel MEI.
-	   For more information:
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "About Intel AMT" => "Local Access"
-
-	   For downloading Intel LMS:
-	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
-
-	   The Intel LMS opens a connection using the Intel MEI driver to the Intel LMS
-	   firmware feature using a defined UUID and then communicates with the feature
-	   using a protocol called Intel AMT Port Forwarding Protocol (Intel APF protocol).
-	   The protocol is used to maintain multiple sessions with Intel AMT from a
-	   single application.
-
-	   See the protocol specification in the Intel AMT Software Development Kit (SDK)
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
-	   => "Information for Intel(R) vPro(TM) Gateway Developers"
-	   => "Description of the Intel AMT Port Forwarding (APF) Protocol"
-
-	2) Intel AMT Remote configuration using a Local Agent
-
-	   A Local Agent enables IT personnel to configure Intel AMT out-of-the-box
-	   without requiring installing additional data to enable setup. The remote
-	   configuration process may involve an ISV-developed remote configuration
-	   agent that runs on the host.
-	   For more information:
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "Setup and Configuration of Intel AMT" =>
-	   "SDK Tools Supporting Setup and Configuration" =>
-	   "Using the Local Agent Sample"
-
-	   An open source Intel AMT configuration utility,	implementing a local agent
-	   that accesses the Intel MEI driver, can be found here:
-	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
-
-
-Intel AMT OS Health Watchdog
-============================
-
-The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
-Whenever the OS hangs or crashes, Intel AMT will send an event
-to any subscriber to this event. This mechanism means that
-IT knows when a platform crashes even when there is a hard failure on the host.
-
-The Intel AMT Watchdog is composed of two parts:
-	1) Firmware feature - receives the heartbeats
-	   and sends an event when the heartbeats stop.
-	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
-	   configures the watchdog and sends the heartbeats.
-
-The Intel iAMT watchdog MEI driver uses the kernel watchdog API to configure
-the Intel AMT Watchdog and to send heartbeats to it. The default timeout of the
-watchdog is 120 seconds.
-
-If the Intel AMT is not enabled in the firmware then the watchdog client won't enumerate
-on the me client bus and watchdog devices won't be exposed.
 
 Supported Chipsets
 ==================
 82X38/X48 Express and newer
 
-
----
 linux-mei@linux.intel.com
-- 
2.20.1

